module 0x25aa780e1a71b498897cf8c075b1e8b99a353414f59bbb71d3f03c3d664fc14b::dlmm {
    struct Flash<phantom T0, phantom T1> {
        receipt: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>,
    }

    struct Params has copy, drop {
        active: u64,
        index_ref: u64,
        vol_ref: u64,
        max_acc: u64,
        bin_step: u64,
        vfc: u128,
        base_fee: u64,
        protocol_rate: u64,
    }

    struct Walk has drop {
        scores: vector<u64>,
        amount_a: vector<u64>,
        amount_b: vector<u64>,
        price: vector<u128>,
        share: vector<u128>,
        next: u64,
        end: bool,
        reach: u64,
    }

    public(friend) fun amount_in(arg0: u64, arg1: u128, arg2: bool) : (bool, u64) {
        if (arg1 == 0) {
            return (false, 0)
        };
        if (arg0 == 0) {
            return (true, 0)
        };
        let (v0, v1) = if (arg2) {
            ((arg0 as u256) * 18446744073709551616, (arg1 as u256))
        } else {
            ((arg0 as u256) * (arg1 as u256), 18446744073709551616)
        };
        let v2 = (v0 + v1 - 1) / v1;
        if (v2 >= (18446744073709551615 as u256)) {
            return (false, 0)
        };
        (true, (v2 as u64))
    }

    public(friend) fun amount_out(arg0: u64, arg1: u128, arg2: bool) : (bool, u64) {
        if (arg1 == 0) {
            return (false, 0)
        };
        if (arg0 == 0) {
            return (true, 0)
        };
        let v0 = if (arg2) {
            (arg0 as u256) * (arg1 as u256) / 18446744073709551616
        } else {
            (arg0 as u256) * 18446744073709551616 / (arg1 as u256)
        };
        if (v0 >= (18446744073709551615 as u256)) {
            return (false, 0)
        };
        (true, (v0 as u64))
    }

    public(friend) fun bin_step(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) : (bool, u64, u64) {
        let (v0, v1) = if (arg1) {
            (arg4, arg5)
        } else {
            (arg5, arg4)
        };
        let (v2, v3) = fee_inclusive(arg0, arg2);
        if (!v2) {
            return (false, 0, 0)
        };
        let (v4, v5) = amount_out(arg0 - v3, arg6, arg1);
        if (!v4) {
            return (false, 0, 0)
        };
        let (v6, v7, v8) = if (v5 <= v1) {
            (arg0, v5, v3)
        } else {
            let (v9, v10) = amount_in(v1, arg6, arg1);
            if (!v9) {
                return (false, 0, 0)
            };
            let (v11, v12) = fee_exclusive(v10, arg2);
            if (!v11) {
                return (false, 0, 0)
            };
            if ((v10 as u128) + (v12 as u128) > (arg0 as u128)) {
                return (false, 0, 0)
            };
            (v10 + v12, v1, v12)
        };
        let (v13, v14) = fee_inclusive(v8, arg3);
        if (!v13) {
            return (false, 0, 0)
        };
        let v15 = v8 - v14;
        if ((v0 as u128) + (v6 as u128) > (18446744073709551615 as u128)) {
            return (false, 0, 0)
        };
        if (v15 > 0) {
            if (arg7 == 0) {
                return (false, 0, 0)
            };
            if (growth_overflows(v15, arg7) && 18446744073709551615 - v0 + v6 - v8 < v15) {
                return (false, 0, 0)
            };
        };
        (true, v6, v7)
    }

    fun empty_params() : Params {
        Params{
            active        : 0,
            index_ref     : 0,
            vol_ref       : 0,
            max_acc       : 0,
            bin_step      : 1,
            vfc           : 0,
            base_fee      : 0,
            protocol_rate : 0,
        }
    }

    fun extend<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut Walk, arg2: u64, arg3: bool) {
        if (arg1.end) {
            return
        };
        if (0x1::vector::length<u64>(&arg1.scores) >= 256) {
            arg1.end = true;
            return
        };
        let v0 = arg1.next;
        let v1 = 0;
        let v2 = 0;
        loop {
            if (v0 > 887272) {
                break
            };
            v2 = v2 + 1;
            if (v2 > 256) {
                break
            };
            let v3 = if (v0 > arg2) {
                v0 - arg2
            } else {
                arg2 - v0
            };
            if (v3 > arg1.reach) {
                break
            };
            let v4 = v0 >> 4;
            if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_group<T0, T1>(arg0, v4)) {
                let v5 = v1 + 1;
                v1 = v5;
                if (v5 > 8) {
                    break
                };
                if (arg3) {
                    if (v4 == 0) {
                        break
                    };
                    v0 = v4 * 16 - 1;
                    continue
                };
                v0 = (v4 + 1) * 16;
                continue
            };
            v1 = 0;
            let v6 = id_of(v0);
            if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_bin<T0, T1>(arg0, v6)) {
                let v7 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_bin<T0, T1>(arg0, v6);
                0x1::vector::push_back<u64>(&mut arg1.scores, v0);
                0x1::vector::push_back<u64>(&mut arg1.amount_a, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v7));
                0x1::vector::push_back<u64>(&mut arg1.amount_b, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v7));
                0x1::vector::push_back<u128>(&mut arg1.price, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(v7));
                0x1::vector::push_back<u128>(&mut arg1.share, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::liquidity_share(v7));
                let v8 = if (arg3) {
                    if (v0 == 0) {
                        887272 + 1
                    } else {
                        v0 - 1
                    }
                } else {
                    v0 + 1
                };
                arg1.next = v8;
                return
            };
            if (arg3) {
                if (v0 == 0) {
                    break
                };
                v0 = v0 - 1;
                continue
            };
            v0 = v0 + 1;
        };
        arg1.end = true;
    }

    public(friend) fun fee_exclusive(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 >= 1000000000) {
            return (false, 0)
        };
        if (arg0 == 0 || arg1 == 0) {
            return (true, 0)
        };
        let v0 = ((1000000000 - arg1) as u128);
        let v1 = ((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0;
        if (v1 > (18446744073709551615 as u128)) {
            return (false, 0)
        };
        (true, (v1 as u64))
    }

    public(friend) fun fee_inclusive(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 > 1000000000) {
            return (false, 0)
        };
        if (arg0 == 0 || arg1 == 0) {
            return (true, 0)
        };
        let v0 = ((arg0 as u128) * (arg1 as u128) + (1000000000 as u128) - 1) / (1000000000 as u128);
        if (v0 > (18446744073709551615 as u128)) {
            return (false, 0)
        };
        (true, (v0 as u64))
    }

    public(friend) fun fee_rate(arg0: &Params, arg1: u64) : (bool, u64) {
        let v0 = if (arg0.index_ref >= arg1) {
            arg0.index_ref - arg1
        } else {
            arg1 - arg0.index_ref
        };
        let v1 = arg0.vol_ref + v0 * 10000;
        let v2 = if (v1 > arg0.max_acc) {
            arg0.max_acc
        } else {
            v1
        };
        let v3 = if (arg0.vfc == 0) {
            0
        } else {
            let v4 = (v2 as u256) * (arg0.bin_step as u256);
            let v5 = v4 * v4;
            if (v5 > 340282366920938463463374607431768211455) {
                return (false, 0)
            };
            let v6 = (arg0.vfc as u256) * v5;
            if (v6 > 340282366920938463463374607431768211455) {
                return (false, 0)
            };
            let v7 = v6 + 99999999999;
            if (v7 > 340282366920938463463374607431768211455) {
                return (false, 0)
            };
            v7 / 100000000000
        };
        let v8 = (arg0.base_fee as u256) + v3;
        let v9 = if (v8 < 100000000) {
            v8
        } else {
            100000000
        };
        if (v9 < (arg0.base_fee as u256)) {
            return (false, 0)
        };
        (true, (v9 as u64))
    }

    public fun flash_a2b<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg2, true, true, v0, arg3, arg4, arg5, arg6);
        0x2::balance::destroy_zero<T0>(v2);
        let v5 = Flash<T0, T1>{receipt: 0x1::option::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v4)};
        (v3, v5)
    }

    public fun flash_b2a<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg2, false, true, v0, arg3, arg4, arg5, arg6);
        0x2::balance::destroy_zero<T1>(v3);
        let v5 = Flash<T0, T1>{receipt: 0x1::option::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v4)};
        (v2, v5)
    }

    fun growth_overflows(arg0: u64, arg1: u128) : bool {
        if (arg0 == 0) {
            return false
        };
        if (arg1 == 0) {
            return true
        };
        (arg0 as u256) * 340282366920938463463374607431768211456 > 340282366920938463463374607431768211455 * (arg1 as u256)
    }

    fun id_of(arg0: u64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (arg0 >= 443636) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(((arg0 - 443636) as u32))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(((4294967296 - 443636 - arg0) as u32))
        }
    }

    public fun out<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        if (arg2 == 0 || 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::disable_swap(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::permissions<T0, T1>(arg0))) {
            return 0
        };
        let (v0, v1) = params<T0, T1>(arg0, arg4);
        let v2 = v1;
        if (!v0) {
            return 0
        };
        let v3 = walk(&v2, arg3);
        let v4 = &mut v3;
        probe<T0, T1>(arg0, v4, &v2, arg1, arg2, reserve_out<T0, T1>(arg0, arg1))
    }

    fun params<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : (bool, Params) {
        let v0 = *0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::v_parameters<T0, T1>(arg0);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step_config(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::last_update_timestamp(&v0);
        let v4 = score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0));
        let v5 = score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::index_reference(&v0));
        let v6 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_reference(&v0) as u64);
        if (v2 < v3) {
            return (false, empty_params())
        };
        let v7 = v2 - v3;
        if (v7 >= (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::filter_period(&v1) as u64)) {
            v5 = v4;
            if (v7 < (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::decay_period(&v1) as u64)) {
                let v8 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_accumulator(&v0) as u128) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::reduction_factor(&v1) as u128) / (10000 as u128);
                if (v8 >= (4294967295 as u128)) {
                    return (false, empty_params())
                };
                v6 = (v8 as u64);
            } else {
                v6 = 0;
            };
        };
        let v9 = Params{
            active        : v4,
            index_ref     : v5,
            vol_ref       : v6,
            max_acc       : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::max_volatility_accumulator(&v1) as u64),
            bin_step      : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v1) as u64),
            vfc           : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::variable_fee_control(&v1) as u128),
            base_fee      : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0),
            protocol_rate : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::protocol_fee_rate(&v1),
        };
        (true, v9)
    }

    fun probe<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut Walk, arg2: &Params, arg3: bool, arg4: u64, arg5: u64) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        while (arg4 > 0) {
            if (v1 == 0x1::vector::length<u64>(&arg1.scores)) {
                extend<T0, T1>(arg0, arg1, arg2.active, arg3);
                if (v1 == 0x1::vector::length<u64>(&arg1.scores)) {
                    return 0
                };
            };
            let (v2, v3) = fee_rate(arg2, *0x1::vector::borrow<u64>(&arg1.scores, v1));
            if (!v2) {
                return 0
            };
            let (v4, v5, v6) = bin_step(arg4, arg3, v3, arg2.protocol_rate, *0x1::vector::borrow<u64>(&arg1.amount_a, v1), *0x1::vector::borrow<u64>(&arg1.amount_b, v1), *0x1::vector::borrow<u128>(&arg1.price, v1), *0x1::vector::borrow<u128>(&arg1.share, v1));
            if (!v4) {
                return 0
            };
            arg4 = arg4 - v5;
            v0 = v0 + (v6 as u128);
            v1 = v1 + 1;
        };
        let v7 = if (v0 == 0) {
            true
        } else if (v0 > (18446744073709551615 as u128)) {
            true
        } else {
            v0 > (arg5 as u128)
        };
        if (v7) {
            return 0
        };
        (v0 as u64)
    }

    fun quote<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1));
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = vector[];
        let v3 = v1 > 0 && !0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::disable_swap(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::permissions<T0, T1>(arg1));
        let (v4, v5) = if (v3) {
            params<T0, T1>(arg1, arg4)
        } else {
            (false, empty_params())
        };
        let v6 = v5;
        let v7 = v3 && v4;
        let v8 = if (v7) {
            reserve_out<T0, T1>(arg1, arg2)
        } else {
            0
        };
        let v9 = walk(&v6, arg3);
        let v10 = 0;
        while (v10 < v1) {
            let v11 = if (v7) {
                let v12 = &mut v9;
                probe<T0, T1>(arg1, v12, &v6, arg2, *0x1::vector::borrow<u64>(&v0, v10), v8)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v2, v11);
            v10 = v10 + 1;
        };
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, v2);
    }

    public fun quote_a2b<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        quote<T0, T1>(arg0, arg1, true, arg2, arg3);
    }

    public fun quote_b2a<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        quote<T0, T1>(arg0, arg1, false, arg2, arg3);
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: Flash<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T0> {
        let Flash { receipt: v0 } = arg1;
        if (0x1::option::is_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg2
        };
        let v1 = 0x1::option::destroy_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v0);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v1);
        assert!(0x2::balance::value<T0>(&arg2) >= v2, 7902);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut arg2, v2), 0x2::balance::zero<T1>(), v1, arg3);
        arg2
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: Flash<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : 0x2::balance::Balance<T1> {
        let Flash { receipt: v0 } = arg1;
        if (0x1::option::is_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg2
        };
        let v1 = 0x1::option::destroy_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v0);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v1);
        assert!(0x2::balance::value<T1>(&arg2) >= v2, 7902);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v2), v1, arg3);
        arg2
    }

    fun reserve_out<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool) : u64 {
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::reserves<T0, T1>(arg0);
        if (arg1) {
            v1
        } else {
            v0
        }
    }

    fun score(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        let v0 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0) as u64);
        if (v0 < 2147483648) {
            443636 + v0
        } else {
            443636 - 4294967296 - v0
        }
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4) == v0, 7901);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T1>(), v4, arg3);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4) == v0, 7901);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), arg1, v4, arg3);
        v1
    }

    fun walk(arg0: &Params, arg1: u64) : Walk {
        let v0 = if (arg1 == 0 || arg0.bin_step == 0) {
            887272
        } else {
            arg1 / arg0.bin_step
        };
        Walk{
            scores   : vector[],
            amount_a : vector[],
            amount_b : vector[],
            price    : vector[],
            share    : vector[],
            next     : arg0.active,
            end      : false,
            reach    : v0,
        }
    }

    // decompiled from Move bytecode v7
}

