module 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::atomic_arbitrage {
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        assert!(v0 >= 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_min_sui_amount(), 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_bluefin::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<T0>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<T0>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_bluefin::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        assert!(v0 >= 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_min_sui_amount(), 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_kriya::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        assert!(v0 >= 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_min_sui_amount(), 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_suiswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        assert!(v0 >= 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_min_sui_amount(), 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_turbos::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<T0>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<T0>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_turbos::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        assert!(v0 >= 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_min_sui_amount(), 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_uniswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2), v1, arg2));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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

    public entry fun arb_cross_bluefin_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_cross<T1, T0>(0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_bluefin::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cross-Bluefin-Cetus",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cross-Bluefin-Cetus",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cross_cetus_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_bluefin::swap_cross<T1, T0>(0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cross-Cetus-Bluefin",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cross-Cetus-Bluefin",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cross_cetus_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_cross<T1, T0>(0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cross-Cetus-Cetus",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cross-Cetus-Cetus",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cross_cetus_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_turbos::swap_cross<T1, T0>(0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cross-Cetus-Turbos",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cross-Cetus-Turbos",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    public entry fun arb_cross_turbos_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_bluefin::swap_cross<T1, T0>(0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_turbos::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
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

    public entry fun arb_cross_turbos_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_invalid_amount_error());
        let v2 = 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_cetus::swap_cross<T1, T0>(0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::dex_turbos::swap_cross<T0, T1>(arg0, v1, arg2), v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 0x39bc423e17ae6643f10424f297e88051074030e0e844130c37a6eeaa3e69b916::constants::get_insufficient_profit_error());
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v4,
            success        : true,
            execution_time : 0,
            route          : b"Cross-Turbos-Cetus",
        };
        let v6 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v3,
            profit         : v4,
            timestamp      : 0,
            route          : b"Cross-Turbos-Cetus",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::transfer<ArbitrageResult>(v5, v1);
    }

    // decompiled from Move bytecode v6
}

