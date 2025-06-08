module 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::atomic_arbitrage {
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
        assert!(v0 > 0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        assert!(v0 >= 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_min_sui_amount(), 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_bluefin::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_insufficient_profit_error());
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

    public entry fun arb_cetus_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        assert!(v0 >= 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_min_sui_amount(), 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_kriya::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        assert!(v0 >= 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_min_sui_amount(), 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_suiswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_insufficient_profit_error());
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
        assert!(v0 > 0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        assert!(v0 >= 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_min_sui_amount(), 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_turbos::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_insufficient_profit_error());
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

    public entry fun arb_cetus_uniswap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        assert!(v0 >= 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_min_sui_amount(), 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_invalid_amount_error());
        let v3 = v0 / 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_cetus::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::dex_uniswap::swap(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), v1, arg3));
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0xf8a0beb4827680a408c1daf91ae7db32080a05578aa7b54959a6511324dd5a8::constants::get_insufficient_profit_error());
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

    // decompiled from Move bytecode v6
}

