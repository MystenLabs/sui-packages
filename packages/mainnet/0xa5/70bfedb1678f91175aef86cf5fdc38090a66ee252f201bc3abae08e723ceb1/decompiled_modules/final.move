module 0xa570bfedb1678f91175aef86cf5fdc38090a66ee252f201bc3abae08e723ceb1::final {
    struct FinalVault has key {
        id: 0x2::object::UID,
        sui: 0x2::coin::Coin<0x2::sui::SUI>,
        total_executed: u64,
    }

    struct TradeExecuted has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    public fun balance(arg0: &FinalVault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.sui)
    }

    public entry fun deposit(arg0: &mut FinalVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
    }

    public entry fun execute_trade(arg0: u64, arg1: &mut FinalVault, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.total_executed = arg1.total_executed + 1;
        let v0 = TradeExecuted{
            amount    : arg0,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TradeExecuted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FinalVault{
            id             : 0x2::object::new(arg0),
            sui            : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            total_executed : 0,
        };
        0x2::transfer::share_object<FinalVault>(v0);
    }

    public fun total(arg0: &FinalVault) : u64 {
        arg0.total_executed
    }

    // decompiled from Move bytecode v6
}

