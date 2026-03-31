module 0x773cbb2087921e5613947a31e374b6f5fb4aa3004ef95e817988ec8db7779b03::executor {
    struct ArbitrageProfit has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        trade_id: u64,
    }

    struct ArbVault has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_trades: u64,
        total_profit: u64,
    }

    public entry fun deposit(arg0: &mut ArbVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun execute_arbitrage(arg0: &mut ArbVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_profit = arg0.total_profit + arg2;
        let v0 = ArbitrageProfit{
            amount_in  : arg1,
            amount_out : arg1 + arg2,
            profit     : arg2,
            trade_id   : arg0.total_trades,
        };
        0x2::event::emit<ArbitrageProfit>(v0);
    }

    public fun get_balance(arg0: &ArbVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_stats(arg0: &ArbVault) : (u64, u64) {
        (arg0.total_trades, arg0.total_profit)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbVault{
            id           : 0x2::object::new(arg0),
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            total_trades : 0,
            total_profit : 0,
        };
        0x2::transfer::share_object<ArbVault>(v0);
    }

    // decompiled from Move bytecode v6
}

