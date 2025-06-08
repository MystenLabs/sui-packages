module 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::atomic_arbitrage {
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

    public entry fun arb_cetus_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_min_sui_amount(), 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_bluefin::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-Bluefin",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-Bluefin",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cetus_bluefin_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<T0>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<T0>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_bluefin::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<T0>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-Bluefin-Generic",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-Bluefin-Generic",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cetus_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_min_sui_amount(), 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_kriya::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-Kriya",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-Kriya",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cetus_suiswap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_min_sui_amount(), 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_suiswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-SuiSwap",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-SuiSwap",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cetus_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_min_sui_amount(), 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_turbos::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-Turbos",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-Turbos",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cetus_turbos_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<T0>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<T0>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_turbos::swap_generic<T0>(0x2::coin::split<T0>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<T0>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-Turbos-Generic",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-Turbos-Generic",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cetus_uniswap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        assert!(v0 >= 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_min_sui_amount(), 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_uniswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cetus-UniswapV2",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cetus-UniswapV2",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_bluefin_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap_cross<T1, T0>(0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_bluefin::swap_cross<T0, T1>(arg0, v1, arg3), v1, arg3);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
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

    public entry fun arb_cross_cetus_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_bluefin::swap_cross<T1, T0>(0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap_cross<T0, T1>(arg0, v1, arg3), v1, arg3);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
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

    public entry fun arb_cross_cetus_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_turbos::swap_cross<T1, T0>(0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap_cross<T0, T1>(arg0, v1, arg3), v1, arg3);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
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

    public entry fun arb_cross_turbos_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_bluefin::swap_cross<T1, T0>(0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_turbos::swap_cross<T0, T1>(arg0, v1, arg3), v1, arg3);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-Turbos-Bluefin",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-Turbos-Bluefin",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_cross_turbos_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_invalid_amount_error());
        let v3 = 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_cetus::swap_cross<T1, T0>(0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::dex_turbos::swap_cross<T0, T1>(arg0, v1, arg3), v1, arg3);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xceaa56aaf81552b165fbfce023f71d4a0532c55eea34ac83ce08ced22485e6d1::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
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

