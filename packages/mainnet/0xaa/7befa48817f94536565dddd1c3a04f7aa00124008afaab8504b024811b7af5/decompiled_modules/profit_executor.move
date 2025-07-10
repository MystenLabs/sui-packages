module 0xaa7befa48817f94536565dddd1c3a04f7aa00124008afaab8504b024811b7af5::profit_executor {
    struct ProfitMaker has key {
        id: 0x2::object::UID,
        owner: address,
        total_profit: u64,
        executions: u64,
        active: bool,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ProfitCaptured has copy, drop {
        amount: u64,
        total: u64,
    }

    public entry fun execute_with_profit(arg0: &mut ProfitMaker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg0.active, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3);
        arg0.executions = arg0.executions + 1;
        arg0.total_profit = arg0.total_profit + v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, arg1);
        let v1 = ProfitCaptured{
            amount : v0,
            total  : arg0.total_profit,
        };
        0x2::event::emit<ProfitCaptured>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfitMaker{
            id           : 0x2::object::new(arg0),
            owner        : 0x2::tx_context::sender(arg0),
            total_profit : 0,
            executions   : 0,
            active       : true,
            treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ProfitMaker>(v0);
    }

    public entry fun toggle(arg0: &mut ProfitMaker, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = !arg0.active;
    }

    public entry fun withdraw(arg0: &mut ProfitMaker, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, arg1, arg2), arg0.owner);
    }

    public entry fun withdraw_all(arg0: &mut ProfitMaker, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, v0, arg1), arg0.owner);
        };
    }

    // decompiled from Move bytecode v6
}

