module 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::atomic_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        gas_used: u64,
        timestamp: u64,
    }

    public entry fun arb_bluefin_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_deepbook::swap_usdc_to_sui<T1, T0>(arg1, 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_bluefin::swap_sui_to_usdc<T0, T1>(arg0, arg2, 0, 0, arg5, arg6), v0 + arg3, 0, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"BLUEFIN->DEEPBOOK",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_turbos<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos::swap_usdc_to_sui<T1, T0>(arg1, 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_bluefin::swap_sui_to_usdc<T0, T1>(arg0, arg2, 0, 0, arg5, arg6), v0 + arg3, 0, arg5, 500, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"BLUEFIN->TURBOS",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_sui_usdc_bluefin_turbos<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos::swap_usdc_to_sui<T0, 0x2::sui::SUI>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::turbos_sui_usdc_pool(), 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_bluefin::swap_sui_to_usdc<0x2::sui::SUI, T0>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::bluefin_sui_usdc_pool(), arg0, 0, 0, arg3, arg4), v0 + arg1, 0, arg3, 500, arg4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg1, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"BLUEFIN_SUI_USDC->TURBOS_USDC_SUI",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun arb_sui_usdc_multi_dex<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(0x1::vector::length<u8>(&arg1) == 2, 1103);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = *0x1::vector::borrow<u8>(&arg1, 0);
        let v2 = *0x1::vector::borrow<u8>(&arg1, 1);
        let v3 = if (v1 == 0) {
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_bluefin::swap_sui_to_usdc<0x2::sui::SUI, T0>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::bluefin_sui_usdc_pool(), arg0, 0, 0, arg4, arg5)
        } else if (v1 == 1) {
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos::swap_sui_to_usdc<0x2::sui::SUI, T0>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::turbos_sui_usdc_pool(), arg0, 0, 0, arg4, 500, arg5)
        } else if (v1 == 2) {
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_kriya::swap_sui_to_usdc<0x2::sui::SUI, T0>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::kriya_sui_usdc_pool(), arg0, 0, 0, arg4, arg5)
        } else {
            assert!(v1 == 3, 1103);
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_deepbook::swap_sui_to_usdc<0x2::sui::SUI, T0>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::deepbook_sui_usdc_pool(), arg0, 0, 0, arg4, arg5)
        };
        let v4 = if (v2 == 0) {
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_bluefin::swap_usdc_to_sui<T0, 0x2::sui::SUI>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::bluefin_sui_usdc_pool(), v3, v0 + arg2, 0, arg4, arg5)
        } else if (v2 == 1) {
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos::swap_usdc_to_sui<T0, 0x2::sui::SUI>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::turbos_sui_usdc_pool(), v3, v0 + arg2, 0, arg4, 500, arg5)
        } else if (v2 == 2) {
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_kriya::swap_usdc_to_sui<T0, 0x2::sui::SUI>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::kriya_sui_usdc_pool(), v3, v0 + arg2, 0, arg4, arg5)
        } else {
            assert!(v2 == 3, 1103);
            0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_deepbook::swap_usdc_to_sui<T0, 0x2::sui::SUI>(0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::deepbook_sui_usdc_pool(), v3, v0 + arg2, 0, arg4, arg5)
        };
        let v5 = v4;
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        assert!(v7 >= arg2, 1101);
        let v8 = ArbitrageExecuted{
            route         : arg1,
            input_amount  : v0,
            output_amount : v6,
            profit        : v7,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageExecuted>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg5));
    }

    public entry fun arb_turbos_bluefin<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_bluefin::swap_usdc_to_sui<T1, T0>(arg1, 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos::swap_sui_to_usdc<T0, T1>(arg0, arg2, 0, 0, arg5, 500, arg6), v0 + arg3, 0, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"TURBOS->BLUEFIN",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_turbos_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_deepbook::swap_usdc_to_sui<T1, T0>(arg1, 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos::swap_sui_to_usdc<T0, T1>(arg0, arg2, 0, 0, arg5, 500, arg6), v0 + arg3, 0, arg5, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"TURBOS->DEEPBOOK",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        }
    }

    public fun check_arbitrage_opportunity(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (bool, u64) {
        let v0 = (arg2 + arg2 * arg3 / 10000) * arg1 / 1000000;
        let v1 = (arg2 - arg2 * arg4 / 10000) * arg0 / 1000000;
        if (v1 > v0) {
            (true, v1 - v0)
        } else {
            (false, 0)
        }
    }

    // decompiled from Move bytecode v6
}

