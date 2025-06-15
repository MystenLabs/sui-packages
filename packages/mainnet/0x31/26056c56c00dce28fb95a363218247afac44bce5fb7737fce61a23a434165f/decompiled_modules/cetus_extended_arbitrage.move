module 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::cetus_extended_arbitrage {
    struct CetusArbitrageExecuted has copy, drop {
        route: vector<u8>,
        dex1: vector<u8>,
        dex2: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun arb_bluefin_cetus<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 2002);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2003);
        let v1 = 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_cetus::swap<T1, T0>(arg1, 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_bluefin::swap<T0, T1>(arg0, arg2, 0, true, arg6), v0 + arg3, 0, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 2001);
        let v4 = CetusArbitrageExecuted{
            route      : b"BLUEFIN->CETUS",
            dex1       : b"BLUEFIN",
            dex2       : b"CETUS",
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CetusArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_cetus_aftermath<T0, T1>(arg0: address, arg1: address, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 2002);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 2003);
        let v1 = 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_aftermath::swap<T1, T0>(arg1, arg2, 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_cetus::swap<T0, T1>(arg0, arg3, 0, 0, arg7), v0 + arg4, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg4, 2001);
        let v4 = CetusArbitrageExecuted{
            route      : b"CETUS->AFTERMATH",
            dex1       : b"CETUS",
            dex2       : b"AFTERMATH",
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CetusArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun arb_cetus_bluefin<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 2002);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2003);
        let v1 = 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_bluefin::swap<T1, T0>(arg1, 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_cetus::swap<T0, T1>(arg0, arg2, 0, 0, arg6), v0 + arg3, false, arg6);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 2001);
        let v4 = CetusArbitrageExecuted{
            route      : b"CETUS->BLUEFIN",
            dex1       : b"CETUS",
            dex2       : b"BLUEFIN",
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CetusArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun arb_cetus_bluefin_kriya<T0, T1, T2>(arg0: address, arg1: address, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 2002);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 2003);
        let v1 = 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_kriya::swap<T2, T0>(arg2, 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_bluefin::swap<T1, T2>(arg1, 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_cetus::swap<T0, T1>(arg0, arg3, 0, 0, arg8), 0, true, arg8), v0 + arg4, arg5, arg8);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg4, 2001);
        let v4 = CetusArbitrageExecuted{
            route      : b"CETUS->BLUEFIN->KRIYA",
            dex1       : b"CETUS",
            dex2       : b"KRIYA",
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<CetusArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg8));
    }

    public entry fun arb_cetus_kriya<T0, T1>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 2002);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2003);
        let v1 = 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_kriya::swap<T1, T0>(arg1, 0x3126056c56c00dce28fb95a363218247afac44bce5fb7737fce61a23a434165f::dex_cetus::swap<T0, T1>(arg0, arg2, 0, 0, arg7), v0 + arg3, arg4, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        assert!(v3 >= arg3, 2001);
        let v4 = CetusArbitrageExecuted{
            route      : b"CETUS->KRIYA",
            dex1       : b"CETUS",
            dex2       : b"KRIYA",
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CetusArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

