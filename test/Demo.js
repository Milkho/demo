const Demo = artifacts.require('Demo');

const promisifyLogWatch = require('./helpers/promisifyLogWatch')

contract('DEMO - test', (accounts) => {
    
    beforeEach(async () => {
        this.demo = await Demo.new();
        // await this.demo.sendTransaction({ value: ether(0.1) });
    });

    it('should create contract with correct params', async() => {
        const param1 = 3443;
        const param2 = "dfg9nun49^%*&V^%";
        const param3 = "gfdg(%^&%^%(*^&$R^%fd";

        await this.demo.makeCall(param1, param2, param3);

        // const revenueEventLog = await promisifyLogWatch(this.demo.RevenueEvent({ fromBlock: 'latest' }));
        // assert.equal(revenueEventLog.event, 'RevenueEvent');
    
        // const beneficiary = revenueEventLog.args.beneficiary;
        // assert.equal(accounts[0], beneficiary);
    });

});