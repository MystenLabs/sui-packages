module 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::atomic_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        gas_used: u64,
        timestamp: u64,
    }

    public entry fun arb_aftermath_bluefin<T0, T1>(arg0: address, arg1: u8, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_bluefin::swap<T1, T0>(arg2, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_aftermath::swap<T0, T1>(arg0, arg1, arg3, 0, arg7), v0 + arg4, false, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg4, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"AFTERMATH->BLUEFIN",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun arb_bluefin_cetus<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_cetus::swap<T1, T0>(arg1, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6), v0 + arg3, 0, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"BLUEFIN->CETUS",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_cetus_turbos<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_turbos::swap<T1, T0>(arg1, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_cetus::swap<T0, T1>(arg0, arg2, 0, 0, arg6), v0 + arg3, 0, true, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"CETUS->TURBOS",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_deepbook_kriya<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_kriya::swap<T1, T0>(arg1, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_deepbook::place_market_order<T0, T1>(arg0, arg2, true, 0, arg6, arg7), v0 + arg3, arg4, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"DEEPBOOK->KRIYA",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun arb_kriya_aftermath<T0, T1>(arg0: address, arg1: address, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_aftermath::swap<T1, T0>(arg1, arg2, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_kriya::swap<T0, T1>(arg0, arg3, 0, false, arg7), v0 + arg4, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg4, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"KRIYA->AFTERMATH",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun arb_three_hop_bct<T0, T1, T2>(arg0: address, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_turbos::swap<T2, T0>(arg2, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_cetus::swap<T1, T2>(arg1, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_bluefin::swap<T0, T1>(arg0, arg3, 0, true, arg7), 0, 0, arg7), v0 + arg4, 0, true, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg4, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"BLUEFIN->CETUS->TURBOS",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun arb_turbos_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_deepbook::place_market_order<T1, T0>(arg1, 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_turbos::swap<T0, T1>(arg0, arg2, 0, 0, true, arg6), false, v0 + arg3, arg5, arg6);
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

