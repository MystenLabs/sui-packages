module 0xc5a87e4f2fd3f0ff0ca91e0ce582403a0733bd6aeb4c0ddb755501e8838b7607::arbitrage {
    struct Arbitrage has key {
        id: 0x2::object::UID,
        owner: address,
        total_profit: u64,
        total_volume: u64,
        successful_arbs: u64,
        failed_arbs: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        min_profit_threshold: u64,
        active: bool,
    }

    struct ArbitrageExecuted has copy, drop {
        loan_amount: u64,
        profit: u64,
        dex: u8,
        success: bool,
    }

    public fun execute_arbitrage_for_flash_loan(arg0: &mut Arbitrage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert!(arg0.active, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == arg2, 2);
        let v1 = if (arg4 > v0) {
            arg4
        } else {
            v0
        };
        if (v1 > arg3) {
            let v2 = v1 - arg3;
            if (v2 >= arg0.min_profit_threshold) {
                arg0.total_profit = arg0.total_profit + v2;
                arg0.successful_arbs = arg0.successful_arbs + 1;
                let v3 = ArbitrageExecuted{
                    loan_amount : v0,
                    profit      : v2,
                    dex         : arg5,
                    success     : true,
                };
                0x2::event::emit<ArbitrageExecuted>(v3);
            };
        } else {
            arg0.failed_arbs = arg0.failed_arbs + 1;
            let v4 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : 0,
                dex         : arg5,
                success     : false,
            };
            0x2::event::emit<ArbitrageExecuted>(v4);
        };
        arg0.total_volume = arg0.total_volume + v0;
        arg1
    }

    public fun execute_real_arbitrage_with_pools(arg0: &mut Arbitrage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert!(arg0.active, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == arg2, 2);
        let v1 = execute_real_cetus_arbitrage(arg1, arg3, arg4, arg7);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        if (v2 > arg3) {
            let v3 = v2 - arg3;
            arg0.total_profit = arg0.total_profit + v3;
            arg0.successful_arbs = arg0.successful_arbs + 1;
            let v4 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : v3,
                dex         : arg5,
                success     : true,
            };
            0x2::event::emit<ArbitrageExecuted>(v4);
        } else {
            arg0.failed_arbs = arg0.failed_arbs + 1;
            let v5 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : 0,
                dex         : arg5,
                success     : false,
            };
            0x2::event::emit<ArbitrageExecuted>(v5);
        };
        arg0.total_volume = arg0.total_volume + v0;
        v1
    }

    fun execute_real_cetus_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 4);
        arg0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Arbitrage{
            id                   : 0x2::object::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            total_profit         : 0,
            total_volume         : 0,
            successful_arbs      : 0,
            failed_arbs          : 0,
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            min_profit_threshold : 1000000,
            active               : true,
        };
        0x2::transfer::share_object<Arbitrage>(v0);
    }

    public fun stats(arg0: &Arbitrage) : (u64, u64, u64, u64, u64) {
        (arg0.total_profit, arg0.total_volume, arg0.successful_arbs, arg0.failed_arbs, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public entry fun toggle_active(arg0: &mut Arbitrage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = !arg0.active;
    }

    public entry fun withdraw_all_profits(arg0: &mut Arbitrage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, v0, arg1), arg0.owner);
        };
    }

    public entry fun withdraw_profits(arg0: &mut Arbitrage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

