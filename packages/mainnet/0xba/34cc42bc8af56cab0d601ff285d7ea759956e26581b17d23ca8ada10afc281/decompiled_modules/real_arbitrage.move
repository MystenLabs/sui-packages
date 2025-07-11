module 0xba34cc42bc8af56cab0d601ff285d7ea759956e26581b17d23ca8ada10afc281::real_arbitrage {
    struct RealArbitrage has key {
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
        path: vector<u8>,
        success: bool,
    }

    fun execute_dual_dex_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = swap_on_cetus(arg0, arg2, arg5);
        let v1 = swap_on_turbos(arg1, arg3, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0x2::coin::value<0x2::sui::SUI>(&v1)) {
            let v4 = reverse_swap_on_turbos(v0, arg5);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
            let v5 = arg2 + arg3;
            let v6 = 0x2::coin::value<0x2::sui::SUI>(&v4);
            let v7 = if (v6 > v5) {
                v6 - v5
            } else {
                0
            };
            (v4, v7)
        } else {
            let v8 = reverse_swap_on_cetus(v1, arg5);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            let v9 = arg2 + arg3;
            let v10 = 0x2::coin::value<0x2::sui::SUI>(&v8);
            let v11 = if (v10 > v9) {
                v10 - v9
            } else {
                0
            };
            (v8, v11)
        }
    }

    public fun execute_real_flash_arbitrage(arg0: &mut RealArbitrage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(arg0.active, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == arg2, 2);
        let v1 = v0 / 2;
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg5);
        let (v3, v4) = execute_dual_dex_arbitrage(v2, arg1, v1, v0 - v1, arg4, arg5);
        let v5 = v3;
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        assert!(v6 >= arg3, 3);
        if (v4 > 0) {
            arg0.total_profit = arg0.total_profit + v4;
            arg0.successful_arbs = arg0.successful_arbs + 1;
            if (v6 > arg3) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v6 - arg3, arg5)));
            };
            let v7 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : v4,
                path        : b"cetus_turbos",
                success     : true,
            };
            0x2::event::emit<ArbitrageExecuted>(v7);
        } else {
            arg0.failed_arbs = arg0.failed_arbs + 1;
            let v8 = ArbitrageExecuted{
                loan_amount : v0,
                profit      : 0,
                path        : b"failed",
                success     : false,
            };
            0x2::event::emit<ArbitrageExecuted>(v8);
        };
        arg0.total_volume = arg0.total_volume + v0;
        v5
    }

    public fun get_stats(arg0: &RealArbitrage) : (u64, u64, u64, u64, u64) {
        (arg0.total_profit, arg0.total_volume, arg0.successful_arbs, arg0.failed_arbs, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RealArbitrage{
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
        0x2::transfer::share_object<RealArbitrage>(v0);
    }

    fun reverse_swap_on_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0
    }

    fun reverse_swap_on_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0
    }

    fun swap_on_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0
    }

    fun swap_on_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0
    }

    public entry fun toggle_active(arg0: &mut RealArbitrage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = !arg0.active;
    }

    public entry fun withdraw_profits(arg0: &mut RealArbitrage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

