module 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::atomic_arbitrage {
    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
        route: vector<u8>,
    }

    struct ArbitrageResult has store, key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
        route: vector<u8>,
    }

    public entry fun arb_cetus_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_min_sui_amount(), 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_bluefin::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-Bluefin",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-Bluefin",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cetus_bluefin_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<T0>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<T0>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_bluefin::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-Bluefin-Generic",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-Bluefin-Generic",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cetus_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_min_sui_amount(), 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_kriya::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-Kriya",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-Kriya",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cetus_suiswap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_min_sui_amount(), 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_suiswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-SuiSwap",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-SuiSwap",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cetus_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_min_sui_amount(), 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_turbos::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-Turbos",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-Turbos",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cetus_turbos_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<T0>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<T0>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_turbos::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-Turbos-Generic",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-Turbos-Generic",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cetus_uniswap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_min_sui_amount(), 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_uniswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cetus-UniswapV2",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cetus-UniswapV2",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cross_bluefin_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v3 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross<T1, T0>(arg0, arg1, arg2, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_bluefin::swap_cross<T0, T1>(arg3, v1, arg6), arg5, v1, arg6);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg4, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg6),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Bluefin-Cetus",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Bluefin-Cetus",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_cetus_bluefin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v3 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_bluefin::swap_cross<T1, T0>(0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross<T0, T1>(arg0, arg1, arg2, arg3, arg5, v1, arg6), v1, arg6);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg4, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg6),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Cetus-Bluefin",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Cetus-Bluefin",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_cetus_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v3 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross<T1, T0>(arg0, arg2, arg3, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross<T0, T1>(arg0, arg1, arg3, arg4, arg6, v1, arg7), arg6, v1, arg7);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg5, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg7),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Cetus-Cetus",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Cetus-Cetus",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_cetus_cetus_simple<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v3 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross_simple<T1, T0>(arg0, arg2, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross_simple<T0, T1>(arg0, arg1, arg3, arg5, v1, arg6), arg5, v1, arg6);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg4, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg6),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Cetus-Cetus-Simple",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Cetus-Cetus-Simple",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_cetus_turbos<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v3 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_turbos::swap_cross<T1, T0>(0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross<T0, T1>(arg0, arg1, arg2, arg3, arg5, v1, arg6), v1, arg6);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg4, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg6),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Cetus-Turbos",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Cetus-Turbos",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_turbos_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v2 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_bluefin::swap_cross<T1, T0>(0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_turbos::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cross-Turbos-Bluefin",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cross-Turbos-Bluefin",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cross_turbos_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > 0, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_invalid_amount_error());
        let v3 = 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_cetus::swap_cross<T1, T0>(arg0, arg1, arg2, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::dex_turbos::swap_cross<T0, T1>(arg3, v1, arg6), arg5, v1, arg6);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg4, 0xa5932a37c93e9053d6c82d9753aeb397846aa4862e13572861a399d29c7051a1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg6),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Turbos-Cetus",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Turbos-Cetus",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    // decompiled from Move bytecode v6
}

