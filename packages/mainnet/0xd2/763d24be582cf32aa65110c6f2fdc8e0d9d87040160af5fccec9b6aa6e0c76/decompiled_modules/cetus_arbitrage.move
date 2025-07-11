module 0xd2763d24be582cf32aa65110c6f2fdc8e0d9d87040160af5fccec9b6aa6e0c76::cetus_arbitrage {
    struct CetusArbitrage has key {
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
        pools_used: vector<address>,
        success: bool,
    }

    public entry fun add_treasury_funds(arg0: &mut CetusArbitrage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun execute_cetus_arbitrage(arg0: &mut CetusArbitrage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert!(arg0.active, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == arg2, 2);
        let (arg1, v1) = if (arg4 > 0 && arg4 >= arg0.min_profit_threshold) {
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg4) {
                0x2::coin::join<0x2::sui::SUI>(&mut arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg4), arg7));
                (arg1, arg4)
            } else {
                (arg1, 0)
            }
        } else {
            (arg1, 0)
        };
        if (v1 > 0) {
            arg0.total_profit = arg0.total_profit + v1;
            arg0.successful_arbs = arg0.successful_arbs + 1;
            let v2 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : v1,
                pools_used  : arg5,
                success     : true,
            };
            0x2::event::emit<ArbitrageExecuted>(v2);
        } else {
            arg0.failed_arbs = arg0.failed_arbs + 1;
            let v3 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : 0,
                pools_used  : arg5,
                success     : false,
            };
            0x2::event::emit<ArbitrageExecuted>(v3);
        };
        arg0.total_volume = arg0.total_volume + v0;
        arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusArbitrage{
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
        0x2::transfer::share_object<CetusArbitrage>(v0);
    }

    public fun stats(arg0: &CetusArbitrage) : (u64, u64, u64, u64, u64) {
        (arg0.total_profit, arg0.total_volume, arg0.successful_arbs, arg0.failed_arbs, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public entry fun withdraw_profits(arg0: &mut CetusArbitrage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

