module 0x695e2e8629657add44ff0ac69f0ff7b68b050276134d1b5a4ef0315fe9fa935e::curve {
    struct State has copy, drop, store {
        price: u128,
        ideal: u128,
        maximum: u128,
        limit: u64,
        base: u64,
        quote: u64,
        fee_base: u64,
        fee_max: u64,
        swap_fee: u64,
        lp_share: u64,
        minimum: u64,
        sell: bool,
        ready: bool,
        shares: u64,
        protocol_balance: u64,
        reward_rps: u128,
    }

    public fun decode(arg0: vector<u128>) : State {
        assert!(0x1::vector::length<u128>(&arg0) == 16, 1200);
        State{
            price            : *0x1::vector::borrow<u128>(&arg0, 0),
            ideal            : *0x1::vector::borrow<u128>(&arg0, 1),
            maximum          : *0x1::vector::borrow<u128>(&arg0, 2),
            limit            : (*0x1::vector::borrow<u128>(&arg0, 3) as u64),
            base             : (*0x1::vector::borrow<u128>(&arg0, 4) as u64),
            quote            : (*0x1::vector::borrow<u128>(&arg0, 5) as u64),
            fee_base         : (*0x1::vector::borrow<u128>(&arg0, 6) as u64),
            fee_max          : (*0x1::vector::borrow<u128>(&arg0, 7) as u64),
            swap_fee         : (*0x1::vector::borrow<u128>(&arg0, 8) as u64),
            lp_share         : (*0x1::vector::borrow<u128>(&arg0, 9) as u64),
            minimum          : (*0x1::vector::borrow<u128>(&arg0, 10) as u64),
            sell             : *0x1::vector::borrow<u128>(&arg0, 11) == 1,
            ready            : *0x1::vector::borrow<u128>(&arg0, 12) == 1,
            shares           : (*0x1::vector::borrow<u128>(&arg0, 13) as u64),
            protocol_balance : (*0x1::vector::borrow<u128>(&arg0, 14) as u64),
            reward_rps       : *0x1::vector::borrow<u128>(&arg0, 15),
        }
    }

    public fun evaluate(arg0: &State, arg1: u64) : (u64, u64, u64, u8) {
        if (!ready(arg0)) {
            return (0, 0, 0, 2)
        };
        if (arg1 == 0) {
            return (0, 0, 0, 1)
        };
        let v0 = (arg1 as u128) * (1000000000000000000 as u128) / (arg0.price as u128);
        if (v0 > (18446744073709551615 as u128)) {
            return (0, 0, 0, 5)
        };
        if (!arg0.sell && v0 == 0) {
            return (0, 0, 0, 1)
        };
        let v1 = if (arg0.sell) {
            v0
        } else {
            (arg1 as u128)
        };
        let v2 = (arg0.quote as u128);
        let v3 = if (arg0.sell) {
            if (v2 >= v1) {
                v2 - v1
            } else {
                0
            }
        } else {
            v2 + v1
        };
        if (v3 > (18446744073709551615 as u128)) {
            return (0, 0, 0, 5)
        };
        let v4 = if (arg0.ideal == 0) {
            0
        } else if (v3 <= (arg0.ideal as u128)) {
            (arg0.fee_base as u128) * v3 / (arg0.ideal as u128)
        } else if (arg0.maximum == 0) {
            (arg0.fee_base as u128)
        } else {
            (arg0.fee_base as u128) + (arg0.fee_max as u128) * v3 / (arg0.maximum as u128)
        };
        if (v4 > (18446744073709551615 as u128) || v4 + (arg0.swap_fee as u128) > (10000000 as u128)) {
            return (0, 0, 0, 5)
        };
        if (!arg0.sell && v3 > (arg0.limit as u128)) {
            return (0, (v4 as u64), 0, 7)
        };
        let v5 = if (arg0.sell) {
            (arg1 as u128)
        } else {
            v0
        };
        let v6 = v5 - v5 * ((10000000 as u128) - v4 - (arg0.swap_fee as u128)) / (10000000 as u128);
        let v7 = v6 * (arg0.lp_share as u128) / 10000;
        let v8 = if (v7 > 0) {
            v7
        } else {
            1
        };
        if (v8 > v6 || v8 > (18446744073709551615 as u128)) {
            return (0, (v4 as u64), 0, 5)
        };
        let v9 = v6 - v8;
        let v10 = if (v9 > 0) {
            v9
        } else {
            1
        };
        if (v8 + v10 > v5) {
            return (0, (v4 as u64), 0, 5)
        };
        let v11 = v5 - v8 - v10;
        let v12 = if (v10 + (arg0.protocol_balance as u128) > (18446744073709551615 as u128)) {
            true
        } else if (v8 * (1000000000000000000 as u128) / (arg0.shares as u128) > (340282366920938463463374607431768211455 as u128) - arg0.reward_rps) {
            true
        } else {
            arg0.sell && (arg0.base as u128) + v11 + v8 > (18446744073709551615 as u128)
        };
        if (v12) {
            return (0, (v4 as u64), (v10 as u64), 7)
        };
        let v13 = if (arg0.sell) {
            v11 * (1000000000000000000 as u128) / (arg0.price as u128)
        } else {
            v11
        };
        if (v13 > (18446744073709551615 as u128)) {
            return (0, (v4 as u64), (v10 as u64), 5)
        };
        if (arg0.sell && v13 > v2 || !arg0.sell && v13 + v10 > (arg0.base as u128)) {
            return (0, (v4 as u64), (v10 as u64), 7)
        };
        if (v13 < (arg0.minimum as u128)) {
            return (0, (v4 as u64), (v10 as u64), 1)
        };
        ((v13 as u64), (v4 as u64), (v10 as u64), 0)
    }

    public fun input_breakpoints(arg0: &State) : vector<u128> {
        let v0 = vector[];
        let v1 = 0x1::vector::empty<u128>();
        let v2 = &mut v1;
        0x1::vector::push_back<u128>(v2, arg0.ideal);
        0x1::vector::push_back<u128>(v2, arg0.maximum);
        0x1::vector::push_back<u128>(v2, (arg0.limit as u128));
        0x1::vector::push_back<u128>(v2, (arg0.quote as u128));
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v1)) {
            let v4 = *0x1::vector::borrow<u128>(&v1, v3);
            let v5 = if (arg0.sell) {
                if ((arg0.quote as u128) >= v4) {
                    (arg0.quote as u128) - v4
                } else {
                    0
                }
            } else if (v4 >= (arg0.quote as u128)) {
                v4 - (arg0.quote as u128)
            } else {
                0
            };
            let v6 = if (arg0.sell) {
                ((v5 as u256) * (arg0.price as u256) + 1000000000000000000 - 1) / 1000000000000000000
            } else {
                (v5 as u256)
            };
            if (v6 > 0 && v6 <= 18446744073709551615) {
                0x1::vector::push_back<u128>(&mut v0, (v6 as u128));
            };
            v3 = v3 + 1;
        };
        v0
    }

    public fun prepare(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: bool, arg15: u64, arg16: u64, arg17: u128) : vector<u128> {
        if (arg0 == 0) {
            return vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        };
        let v0 = if (arg13) {
            1000000000000000000 * 1000000000000000000 / (arg0 as u256)
        } else {
            (arg0 as u256)
        };
        let v1 = (arg1 as u256) * v0 / 1000000000000000000;
        let v2 = v1 * (arg2 as u256) / 10000;
        let v3 = v1 * (arg3 as u256) / 10000;
        let v4 = v1 * (arg4 as u256) / 10000;
        let v5 = (arg8 as u256) * 1000;
        let v6 = (arg9 as u256) * 1000;
        let v7 = (arg10 as u256) * 1000;
        let v8 = if (v0 > 340282366920938463463374607431768211455) {
            true
        } else if (v1 > 340282366920938463463374607431768211455) {
            true
        } else if (v2 > 340282366920938463463374607431768211455) {
            true
        } else if (v3 > 340282366920938463463374607431768211455) {
            true
        } else if (v4 > 18446744073709551615) {
            true
        } else if (v5 > 18446744073709551615) {
            true
        } else if (v6 > 18446744073709551615) {
            true
        } else {
            v7 > 18446744073709551615
        };
        if (v8) {
            return vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        };
        let v9 = if (v4 < (arg5 as u256)) {
            v4
        } else {
            (arg5 as u256)
        };
        let v10 = if (arg13) {
            1
        } else {
            0
        };
        let v11 = if (arg14) {
            1
        } else {
            0
        };
        let v12 = 0x1::vector::empty<u128>();
        let v13 = &mut v12;
        0x1::vector::push_back<u128>(v13, arg0);
        0x1::vector::push_back<u128>(v13, (v2 as u128));
        0x1::vector::push_back<u128>(v13, (v3 as u128));
        0x1::vector::push_back<u128>(v13, (v9 as u128));
        0x1::vector::push_back<u128>(v13, (arg6 as u128));
        0x1::vector::push_back<u128>(v13, (arg7 as u128));
        0x1::vector::push_back<u128>(v13, (v5 as u128));
        0x1::vector::push_back<u128>(v13, (v6 as u128));
        0x1::vector::push_back<u128>(v13, (v7 as u128));
        0x1::vector::push_back<u128>(v13, (arg11 as u128));
        0x1::vector::push_back<u128>(v13, (arg12 as u128));
        0x1::vector::push_back<u128>(v13, v10);
        0x1::vector::push_back<u128>(v13, v11);
        0x1::vector::push_back<u128>(v13, (arg15 as u128));
        0x1::vector::push_back<u128>(v13, (arg16 as u128));
        0x1::vector::push_back<u128>(v13, arg17);
        v12
    }

    public fun price(arg0: &State) : u128 {
        arg0.price
    }

    public fun ready(arg0: &State) : bool {
        if (arg0.ready) {
            if (arg0.price > 0) {
                arg0.shares > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

