module 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::atomic_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        gas_used: u64,
        timestamp: u64,
    }

    public entry fun arb_aftermath_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_aftermath::swap<T0, T1>(arg0, 0, arg2, 0, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::swap<T1, T0>(arg1, v1, 0, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"AFTERMATH->DEEPBOOK",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_aftermath_kriya<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_aftermath::swap<T0, T1>(arg0, 0, arg2, 0, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<T1, T0>(arg1, v1, 0, true, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"AFTERMATH->KRIYA",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_aftermath_turbos<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_aftermath::swap<T0, T1>(arg0, 0, arg2, 0, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T1, T0>(arg1, v1, 0, 0, true, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"AFTERMATH->TURBOS",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_aftermath<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_aftermath::swap<T1, T0>(arg1, 0, v1, 0, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"BLUEFIN->AFTERMATH",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_cetus<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<T1, T0>(arg1, v1, 0, arg5, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"BLUEFIN->CETUS",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::place_market_order<T1, T0>(arg1, 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6), false, v0 + arg3, arg5, arg6);
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

    public entry fun arb_bluefin_kriya<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<T1, T0>(arg1, v1, 0, true, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"BLUEFIN->KRIYA",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_bluefin_turbos<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T1, T0>(arg1, 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6), v0 + arg3, 0, true, arg6);
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

    public entry fun arb_cetus_aftermath<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<T0, T1>(arg0, arg2, 0, arg5, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_aftermath::swap<T1, T0>(arg1, 0, v1, 0, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"CETUS->AFTERMATH",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_cetus_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<T0, T1>(arg0, arg2, 0, arg5, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::swap<T1, T0>(arg1, v1, 0, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"CETUS->DEEPBOOK",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_cetus_kriya<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<T0, T1>(arg0, arg2, 0, arg5, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<T1, T0>(arg1, v1, 0, true, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"CETUS->KRIYA",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_cetus_turbos<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<T0, T1>(arg0, arg2, 0, arg5, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T1, T0>(arg1, v1, 0, 0, true, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"CETUS->TURBOS",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_kriya_deepbook<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<T0, T1>(arg0, arg2, 0, true, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::swap<T1, T0>(arg1, v1, 0, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"KRIYA->DEEPBOOK",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_sui_usdt_bluefin_turbos<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T0, 0x2::sui::SUI>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::turbos_sui_usdt_pool(), 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<0x2::sui::SUI, T0>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::bluefin_sui_usdt_pool(), arg0, 0, true, arg4), v0 + arg1, 0, false, arg4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg1, 1101);
        let v4 = ArbitrageExecuted{
            route         : b"BLUEFIN_SUI_USDT->TURBOS_USDT_SUI",
            input_amount  : v0,
            output_amount : v2,
            profit        : v3,
            gas_used      : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun arb_sui_usdt_multi_dex<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(0x1::vector::length<u8>(&arg1) == 2, 1103);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = *0x1::vector::borrow<u8>(&arg1, 0);
        let v2 = *0x1::vector::borrow<u8>(&arg1, 1);
        let v3 = if (v1 == 0) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<0x2::sui::SUI, T0>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::bluefin_sui_usdt_pool(), arg0, 0, true, arg5)
        } else if (v1 == 1) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<0x2::sui::SUI, T0>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::turbos_sui_usdt_pool(), arg0, 0, 0, true, arg5)
        } else if (v1 == 2) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<0x2::sui::SUI, T0>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::kriya_sui_usdt_pool(), arg0, 0, true, arg5)
        } else if (v1 == 3) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::swap<0x2::sui::SUI, T0>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::deepbook_sui_usdt_pool(), arg0, 0, arg5)
        } else {
            assert!(v1 == 4, 1103);
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<0x2::sui::SUI, T0>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::get_sui_usdt_pool(), arg0, 0, arg4, arg5)
        };
        let v4 = if (v2 == 0) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T0, 0x2::sui::SUI>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::bluefin_sui_usdt_pool(), v3, v0 + arg2, false, arg5)
        } else if (v2 == 1) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T0, 0x2::sui::SUI>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::turbos_sui_usdt_pool(), v3, v0 + arg2, 0, false, arg5)
        } else if (v2 == 2) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<T0, 0x2::sui::SUI>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::kriya_sui_usdt_pool(), v3, v0 + arg2, true, arg5)
        } else if (v2 == 3) {
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::swap<T0, 0x2::sui::SUI>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::constants::deepbook_sui_usdt_pool(), v3, v0 + arg2, arg5)
        } else {
            assert!(v2 == 4, 1103);
            0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::swap<T0, 0x2::sui::SUI>(0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_cetus::get_sui_usdt_pool(), v3, v0 + arg2, arg4, arg5)
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
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_bluefin::swap<T1, T0>(arg1, 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T0, T1>(arg0, arg2, 0, 0, true, arg6), v0 + arg3, false, arg6);
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
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_deepbook::place_market_order<T1, T0>(arg1, 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T0, T1>(arg0, arg2, 0, 0, true, arg6), false, v0 + arg3, arg5, arg6);
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

    public entry fun arb_turbos_kriya<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_turbos::swap<T0, T1>(arg0, arg2, 0, 0, true, arg6);
        0x2::coin::value<T1>(&v1);
        let v2 = 0xddc8697657afa6efdc5982f558cf54cbbee3cb335666b67d6c692065008deb10::dex_kriya::swap<T1, T0>(arg1, v1, 0, true, arg6);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1101);
        let v5 = ArbitrageExecuted{
            route         : b"TURBOS->KRIYA",
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            gas_used      : 0x2::tx_context::epoch_timestamp_ms(arg6) - 0x2::tx_context::epoch_timestamp_ms(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
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

