module 0x4568ed1893f81fe4bac75de98e2886b474c6b5d3d3ea33bb39ace7df7aed089c::final {
    struct FinalVault has key {
        id: 0x2::object::UID,
        balance: u64,
        trades: u64,
        total_profit: u64,
    }

    struct ArbitrageEvent has copy, drop {
        trade_id: u64,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        trader: address,
    }

    public entry fun deposit(arg0: &mut FinalVault, arg1: u64) {
        arg0.balance = arg0.balance + arg1;
    }

    public entry fun execute_arbitrage(arg0: &mut FinalVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.balance >= arg1 + arg2, 0);
        arg0.trades = arg0.trades + 1;
        arg0.total_profit = arg0.total_profit + arg2;
        let v0 = ArbitrageEvent{
            trade_id   : arg0.trades,
            amount_in  : arg1,
            amount_out : arg1 + arg2,
            profit     : arg2,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ArbitrageEvent>(v0);
    }

    public fun get_stats(arg0: &FinalVault) : (u64, u64, u64) {
        (arg0.balance, arg0.trades, arg0.total_profit)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FinalVault{
            id           : 0x2::object::new(arg0),
            balance      : 0,
            trades       : 0,
            total_profit : 0,
        };
        0x2::transfer::share_object<FinalVault>(v0);
    }

    // decompiled from Move bytecode v6
}

