module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::production_arbitrage {
    struct ArbitrageConfig has store, key {
        id: 0x2::object::UID,
        min_profit_bps: u64,
        max_slippage_bps: u64,
        enabled: bool,
        owner: address,
    }

    struct ArbitrageExecuted has copy, drop {
        executor: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        buy_dex: u8,
        sell_dex: u8,
        timestamp: u64,
    }

    struct EmergencyStop has copy, drop {
        caller: address,
        timestamp: u64,
        reason: vector<u8>,
    }

    public fun calculate_potential_profit(arg0: u64, arg1: u8, arg2: u8) : u64 {
        let v0 = arg0 * (get_dex_fee(arg1) + get_dex_fee(arg2)) / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        }
    }

    public entry fun emergency_stop(arg0: &mut ArbitrageConfig, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 105);
        arg0.enabled = false;
        let v0 = EmergencyStop{
            caller    : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
            reason    : arg1,
        };
        0x2::event::emit<EmergencyStop>(v0);
    }

    public entry fun execute_arbitrage(arg0: &ArbitrageConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 105);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 <= arg6, 104);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 102);
        let v2 = execute_swap_buy(arg1, arg2, arg8);
        0x2::coin::value<0x2::sui::SUI>(&v2);
        let v3 = execute_swap_sell(v2, arg3, arg8);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = if (v4 > v1) {
            v4 - v1
        } else {
            0
        };
        assert!(v5 >= arg4, 101);
        let v6 = if (v4 < v1) {
            (v1 - v4) * 10000 / v1
        } else {
            0
        };
        assert!(v6 <= arg5, 103);
        let v7 = ArbitrageExecuted{
            executor      : 0x2::tx_context::sender(arg8),
            input_amount  : v1,
            output_amount : v4,
            profit        : v5,
            buy_dex       : arg2,
            sell_dex      : arg3,
            timestamp     : v0,
        };
        0x2::event::emit<ArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun execute_arbitrage_via_usdc<T0>(arg0: &ArbitrageConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 105);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = swap_sui_to_usdc<T0>(arg1, arg2, arg6);
        let v2 = swap_usdc_to_sui<T0>(v1, arg3, arg6);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg4, 101);
        let v5 = ArbitrageExecuted{
            executor      : 0x2::tx_context::sender(arg6),
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            buy_dex       : arg2,
            sell_dex      : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg6));
    }

    fun execute_swap_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 1) {
            swap_on_kriya_buy(arg0, arg2)
        } else if (arg1 == 2) {
            swap_on_cetus_buy(arg0, arg2)
        } else if (arg1 == 3) {
            swap_on_turbos_buy(arg0, arg2)
        } else if (arg1 == 4) {
            swap_on_deepbook_buy(arg0, arg2)
        } else if (arg1 == 5) {
            swap_on_bluefin_buy(arg0, arg2)
        } else {
            assert!(arg1 == 6, 105);
            swap_on_aftermath_buy(arg0, arg2)
        }
    }

    fun execute_swap_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 1) {
            swap_on_kriya_sell(arg0, arg2)
        } else if (arg1 == 2) {
            swap_on_cetus_sell(arg0, arg2)
        } else if (arg1 == 3) {
            swap_on_turbos_sell(arg0, arg2)
        } else if (arg1 == 4) {
            swap_on_deepbook_sell(arg0, arg2)
        } else if (arg1 == 5) {
            swap_on_bluefin_sell(arg0, arg2)
        } else {
            assert!(arg1 == 6, 105);
            swap_on_aftermath_sell(arg0, arg2)
        }
    }

    public fun get_config(arg0: &ArbitrageConfig) : (u64, u64, bool) {
        (arg0.min_profit_bps, arg0.max_slippage_bps, arg0.enabled)
    }

    public fun get_dex_fee(arg0: u8) : u64 {
        if (arg0 == 1) {
            30
        } else if (arg0 == 2) {
            25
        } else if (arg0 == 3) {
            30
        } else if (arg0 == 4) {
            10
        } else if (arg0 == 5) {
            25
        } else if (arg0 == 6) {
            25
        } else {
            50
        }
    }

    public entry fun initialize_config(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbitrageConfig{
            id               : 0x2::object::new(arg2),
            min_profit_bps   : arg0,
            max_slippage_bps : arg1,
            enabled          : true,
            owner            : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<ArbitrageConfig>(v0);
    }

    public entry fun resume_operations(arg0: &mut ArbitrageConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 105);
        arg0.enabled = true;
    }

    fun swap_on_aftermath_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 25 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_aftermath_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 25 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_bluefin_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 25 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_bluefin_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 25 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_cetus_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 25 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_cetus_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 25 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_deepbook_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 10 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_deepbook_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 10 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_kriya_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 30 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_kriya_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 30 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_turbos_buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 30 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_on_turbos_sell(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 - v0 * 30 / 10000 > 0, 101);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1)
    }

    fun swap_sui_to_usdc<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
    }

    fun swap_usdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg2)
    }

    // decompiled from Move bytecode v6
}

