module 0xddeb4676e587420a92c2ff73e76a77dc92da6ad1f37158dc8e4d8faacf89dc2c::comprehensive_dex_wrapper {
    struct SwapExecuted has copy, drop {
        dex: vector<u8>,
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        user: address,
        swap_type: vector<u8>,
    }

    struct ArbitrageExecuted has copy, drop {
        dex_buy: vector<u8>,
        dex_sell: vector<u8>,
        pool_buy: 0x2::object::ID,
        pool_sell: 0x2::object::ID,
        amount_in: u64,
        profit: u64,
        user: address,
    }

    struct ComprehensiveDexWrapper has key {
        id: 0x2::object::UID,
        admin: address,
        total_swaps: u64,
        total_volume: u64,
    }

    public entry fun arbitrage_cetus_to_turbos(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(0x2::clock::timestamp_ms(arg6) < arg5, 3);
        arg0.total_swaps = arg0.total_swaps + 2;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = ArbitrageExecuted{
            dex_buy   : b"Cetus",
            dex_sell  : b"Turbos",
            pool_buy  : arg1,
            pool_sell : arg2,
            amount_in : v0,
            profit    : arg4,
            user      : v1,
        };
        0x2::event::emit<ArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v1);
    }

    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 > arg1) {
            arg0 * (arg2 - arg1) / arg1
        } else {
            0
        }
    }

    public entry fun cetus_sui_to_usdc(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"Cetus",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"SUI_to_USDC",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public entry fun cetus_usdc_to_sui<T0>(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"Cetus",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"USDC_to_SUI",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
    }

    public entry fun create_comprehensive_wrapper(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ComprehensiveDexWrapper{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            total_swaps  : 0,
            total_volume : 0,
        };
        0x2::transfer::share_object<ComprehensiveDexWrapper>(v0);
    }

    public entry fun deepbook_sui_to_usdc(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"DeepBook_V3",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"SUI_to_USDC",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public entry fun deepbook_usdc_to_sui<T0>(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"DeepBook_V3",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"USDC_to_SUI",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
    }

    public entry fun execute_atomic_arbitrage(arg0: &mut ComprehensiveDexWrapper, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg8);
        arg0.total_swaps = arg0.total_swaps + 2;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = ArbitrageExecuted{
            dex_buy   : arg1,
            dex_sell  : arg2,
            pool_buy  : arg3,
            pool_sell : arg4,
            amount_in : v0,
            profit    : arg6,
            user      : v1,
        };
        0x2::event::emit<ArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v1);
    }

    public fun get_wrapper_stats(arg0: &ComprehensiveDexWrapper) : (address, u64, u64) {
        (arg0.admin, arg0.total_swaps, arg0.total_volume)
    }

    public entry fun kriya_sui_to_usdc(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"Kriya",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"SUI_to_USDC",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public entry fun kriya_usdc_to_sui<T0>(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"Kriya",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"USDC_to_SUI",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
    }

    public entry fun reset_stats(arg0: &mut ComprehensiveDexWrapper, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
        arg0.total_swaps = 0;
        arg0.total_volume = 0;
    }

    public entry fun turbos_sui_to_usdt(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::clock::timestamp_ms(arg5) < arg4, 3);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"Turbos",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"SUI_to_USDT",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public entry fun turbos_usdt_to_sui<T0>(arg0: &mut ComprehensiveDexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::clock::timestamp_ms(arg5) < arg4, 3);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = SwapExecuted{
            dex        : b"Turbos",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
            swap_type  : b"USDT_to_SUI",
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
    }

    public entry fun update_admin(arg0: &mut ComprehensiveDexWrapper, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public fun validate_pool_id(arg0: 0x2::object::ID) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

