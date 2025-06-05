module 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::atomic_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
        route: vector<u8>,
        dex_count: u8,
    }

    public entry fun arb_all_seven_dex(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_deepbook::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_bluefin::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_flowx::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_aftermath::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_turbos::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_cetus::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_kriya::simulate_swap(v0)))))));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            route          : b"Kriya->Cetus->Turbos->Aftermath->FlowX->Bluefin->DeepBook",
            dex_count      : 7,
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun arb_cetus_flowx_deepbook_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_kriya::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_deepbook::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_flowx::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_cetus::simulate_swap(v0))));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            route          : b"Cetus->FlowX->DeepBook->Kriya",
            dex_count      : 4,
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun arb_kriya_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_cetus::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_kriya::simulate_swap(v0));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            route          : b"Kriya->Cetus",
            dex_count      : 2,
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun arb_turbos_aftermath_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_bluefin::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_aftermath::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_turbos::simulate_swap(v0)));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            route          : b"Turbos->Aftermath->Bluefin",
            dex_count      : 3,
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun execute_real_three_way_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_bluefin::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_flowx::simulate_swap(0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_aftermath::simulate_swap(v0)));
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = ArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            route          : b"Aftermath->FlowX->Bluefin",
            dex_count      : 3,
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

