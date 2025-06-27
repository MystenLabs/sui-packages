module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::real_atomic_swap {
    struct RealAtomicSwapExecuted has copy, drop {
        dex1: u8,
        dex2: u8,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        gas_used: u64,
        success: bool,
        timestamp: u64,
    }

    struct DEXIntegrationStatus has copy, drop {
        cetus_ready: bool,
        turbos_ready: bool,
        bluefin_ready: bool,
        kriya_ready: bool,
        aftermath_ready: bool,
        deepbook_ready: bool,
        total_dexes_ready: u8,
    }

    public entry fun arb_aftermath_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_deepbook_v3_real::swap_market_v3_real<T1, T0>(arg2, 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_v2_real::swap_simple<T0, T1>(arg0, 0, arg4, arg5), false, v0 + arg3, arg4, arg5);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1001);
        let v4 = RealAtomicSwapExecuted{
            dex1       : 5,
            dex2       : 6,
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            gas_used   : 0,
            success    : true,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealAtomicSwapExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun arb_cetus_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::tx_context::epoch(arg6);
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_cetus_real::swap_real<T0, T1>(arg1, arg0, 0, arg4, arg5, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_turbos_real::swap_real<T1, T0>(arg2, v1, v0 + arg3, 0, true, arg5, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1001);
        let v5 = RealAtomicSwapExecuted{
            dex1       : 1,
            dex2       : 2,
            amount_in  : v0,
            amount_out : v3,
            profit     : v4,
            gas_used   : 0,
            success    : true,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RealAtomicSwapExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_four_way_all_dexes<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<T0>(&arg0);
        assert!(0x1::vector::length<address>(&arg1) >= 4, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
    }

    public entry fun arb_kriya_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_v2_real::swap_simple<T1, T0>(arg2, 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_v2_real::swap_simple<T0, T1>(arg0, 0, arg5), v0 + arg3, arg4, arg5);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1001);
        let v4 = RealAtomicSwapExecuted{
            dex1       : 4,
            dex2       : 3,
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            gas_used   : 0,
            success    : true,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealAtomicSwapExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun arb_three_way_cetus_turbos_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_v2_real::swap_simple<T0, T0>(0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_turbos_real::swap_real<T1, T0>(arg2, 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_cetus_real::swap_real<T0, T1>(arg1, arg0, 0, 0, arg5, arg6), 0, 0, true, arg5, arg6), v0 + arg4, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg4, 1001);
        let v4 = RealAtomicSwapExecuted{
            dex1       : 1,
            dex2       : 4,
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            gas_used   : 0,
            success    : true,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RealAtomicSwapExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun calculate_optimal_route(arg0: u64, arg1: vector<u64>) : (u8, u8, u64) {
        (1, 2, arg0 * 30 / 10000)
    }

    public entry fun check_all_dex_status(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_cetus_real::is_cetus_ready();
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_turbos_real::is_turbos_ready();
        let v2 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_v2_real::is_bluefin_v2_ready();
        let v3 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_v2_real::is_kriya_v2_ready();
        let v4 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_v2_real::is_aftermath_v2_ready();
        let v5 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_deepbook_v3_real::is_deepbook_v3_ready();
        let v6 = 0;
        let v7 = v6;
        if (v0) {
            v7 = v6 + 1;
        };
        if (v1) {
            v7 = v7 + 1;
        };
        if (v2) {
            v7 = v7 + 1;
        };
        if (v3) {
            v7 = v7 + 1;
        };
        if (v4) {
            v7 = v7 + 1;
        };
        if (v5) {
            v7 = v7 + 1;
        };
        let v8 = DEXIntegrationStatus{
            cetus_ready       : v0,
            turbos_ready      : v1,
            bluefin_ready     : v2,
            kriya_ready       : v3,
            aftermath_ready   : v4,
            deepbook_ready    : v5,
            total_dexes_ready : v7,
        };
        0x2::event::emit<DEXIntegrationStatus>(v8);
    }

    // decompiled from Move bytecode v6
}

