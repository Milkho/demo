const Demo = artifacts.require('DemoOraclize');

const promisifyLogWatch = require('./helpers/promisifyLogWatch')
const ether = require('./helpers/ether');

contract('DEMO - test', (accounts) => {
    
    beforeEach(async () => {
        this.demo = await Demo.new();
        await this.demo.sendTransaction({ value: ether(1.1) });

        // upload initial data to contract
        await this.demo.uploadData(1, 2, 3, 5, 1000);
    });

    it('test', async() => {
        const userX = 13545;
        const userY = 13545;
        const userZ = 13545;

        const coinX = await this.demo.x.call();
        const coinY = await this.demo.y.call();
        const coinZ = await this.demo.z.call();
        const coinRadius = await this.demo.radius.call();
        const coinTime = await this.demo.time.call();


        // TODO call lib with given parameters above
        // and get three params as reponse
        const param1 = 3443;
        const param2 = "dfg9nun49^%*&V^%";
        const param3 = "gfdg(%^&%^%(*^&$R^%fd";

        // call contract
        await this.demo.makeCall(param1, param2, param3);
        
        const revenueEventLog = await promisifyLogWatch(this.demo.RevenueEvent({ fromBlock: 'latest' }));
        assert.equal(revenueEventLog.event, 'RevenueEvent');
    
        const beneficiary = revenueEventLog.args.beneficiary;
        assert.equal(accounts[0], beneficiary);
    });

});