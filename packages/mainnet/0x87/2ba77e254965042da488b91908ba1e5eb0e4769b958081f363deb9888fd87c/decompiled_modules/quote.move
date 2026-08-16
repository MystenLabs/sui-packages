module 0xefb37677c5c43eb19e019186f0769be08dd42ab18ab1ba7d8dd0a8021d32ede1::quote {
    public fun aftermath_a2b<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: u64, arg3: u8) {
        assert!(arg2 > 0, 402);
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = aftermath_amount_in_after_protocol_fee(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0));
            let v2 = if (v1 == 0) {
                0
            } else {
                0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T2, T0, T1>(arg1, v1, arg2, 1000000000000000000)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, v2);
            v0 = v0 + 1;
        };
    }

    public(friend) fun aftermath_amount_in_after_protocol_fee(arg0: u64) : u64 {
        let v0 = aftermath_mul_by_fraction(arg0, 500000000000000);
        arg0 - aftermath_mul_by_fraction(v0, 500000000000000000) - aftermath_mul_by_fraction(v0, 300000000000000000) - aftermath_mul_by_fraction(v0, 200000000000000000)
    }

    public fun aftermath_b2a<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: u64, arg3: u8) {
        assert!(arg2 > 0, 402);
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = aftermath_amount_in_after_protocol_fee(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0));
            let v2 = if (v1 == 0) {
                0
            } else {
                0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T2, T1, T0>(arg1, v1, arg2, 1000000000000000000)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun aftermath_dao_a2b<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T2>, arg2: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg3: u64, arg4: u8) {
        aftermath_dao_record(arg0, arg3, arg4);
    }

    public fun aftermath_dao_b2a<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T2>, arg2: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg3: u64, arg4: u8) {
        aftermath_dao_record(arg0, arg3, arg4);
    }

    fun aftermath_dao_record(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: u64, arg2: u8) {
        assert!(arg1 > 0, 402);
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, scale_aftermath_expected_out(arg1, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0), 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, 0)));
            v0 = v0 + 1;
        };
    }

    fun aftermath_mul_by_fraction(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 1000000000000000000) as u64)
    }

    public fun bluefin_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, bluefin_out<T0, T1>(arg1, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun bluefin_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, bluefin_out<T0, T1>(arg1, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun bluefin_out<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0xefb37677c5c43eb19e019186f0769be08dd42ab18ab1ba7d8dd0a8021d32ede1::sqrt_limit::bounded(v0, arg1, 4295048017, 79226673515401279992447579054);
        if (!0xefb37677c5c43eb19e019186f0769be08dd42ab18ab1ba7d8dd0a8021d32ede1::sqrt_limit::usable(v0, v1, arg1)) {
            return 0
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, v1);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v2)) {
            0
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2)
        }
    }

    public fun cetus_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, cetus_out<T0, T1>(arg1, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun cetus_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, cetus_out<T0, T1>(arg1, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun cetus_out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            0
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
        }
    }

    public fun deepbook_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        deepbook_record_a2b<T0, T1>(arg0, arg1, arg2, arg3, false);
    }

    public fun deepbook_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        deepbook_record_b2a<T0, T1>(arg0, arg1, arg2, arg3, false);
    }

    public fun deepbook_deep_paid_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        deepbook_record_a2b<T0, T1>(arg0, arg1, arg2, arg3, true);
    }

    public fun deepbook_deep_paid_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        deepbook_record_b2a<T0, T1>(arg0, arg1, arg2, arg3, true);
    }

    fun deepbook_record_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: bool) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else if (arg4) {
                let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v1, arg3);
                v4
            } else {
                let (_, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v1, arg3);
                v7
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, v2);
            v0 = v0 + 1;
        };
    }

    fun deepbook_record_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: bool) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else if (arg4) {
                let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v1, arg3);
                v3
            } else {
                let (v6, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v1, arg3);
                v6
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun dipcoin_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: u8) {
        let (v0, v1, v2) = dipcoin_pool_fields<T0, T1>(arg1);
        let v3 = 0;
        while (v3 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v3, dipcoin_out(v0, v1, v2, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v3)));
            v3 = v3 + 1;
        };
    }

    public fun dipcoin_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: u8) {
        let (v0, v1, v2) = dipcoin_pool_fields<T0, T1>(arg1);
        let v3 = 0;
        while (v3 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v3, dipcoin_out(v1, v0, v2, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v3)));
            v3 = v3 + 1;
        };
    }

    fun dipcoin_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        if (arg2 > 2000) {
            return 0
        };
        let v1 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_out(arg2, arg3, arg0, arg1);
        if (v1 >= arg1) {
            0
        } else {
            v1
        }
    }

    fun dipcoin_pool_fields<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = 0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 96, 403);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        (0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1))
    }

    public fun dlmm_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, dlmm_out<T0, T1>(arg1, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0), arg3));
            v0 = v0 + 1;
        };
    }

    public fun dlmm_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, dlmm_out<T0, T1>(arg1, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0), arg3));
            v0 = v0 + 1;
        };
    }

    fun dlmm_bin_out(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, bool) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(arg0);
        let v1 = if (arg2) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(arg0)
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(arg0)
        };
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_out(arg1 - 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(arg1, arg3), v0, arg2);
        if (v2 <= v1) {
            return (arg1, v2, true)
        };
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(v1, v0, arg2);
        let v4 = v3 + 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v3, arg3);
        if (v4 > arg1) {
            (0, 0, false)
        } else {
            (v4, v1, true)
        }
    }

    fun dlmm_out<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::v_parameters<T0, T1>(arg0);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step_config(v0);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::last_update_timestamp(v0);
        if (v3 < v4) {
            return 0
        };
        let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::index_reference(v0);
        let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_reference(v0);
        let v7 = v3 - v4;
        if (v7 >= (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::filter_period(&v1) as u64)) {
            v5 = v2;
            let v8 = if (v7 < (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::decay_period(&v1) as u64)) {
                (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_accumulator(v0) as u64), (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::reduction_factor(&v1) as u64), 10000) as u32)
            } else {
                0
            };
            v6 = v8;
        };
        let v9 = 0;
        let v10 = 0;
        while (arg2 > 0 && v10 < 64) {
            v10 = v10 + 1;
            if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_bin<T0, T1>(arg0, v2)) {
                let (v11, v12, v13) = dlmm_bin_out(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_bin<T0, T1>(arg0, v2), arg2, arg1, dlmm_total_fee_rate(&v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0), v5, v2, v6));
                if (!v13) {
                    return 0
                };
                arg2 = arg2 - v11;
                v9 = v9 + v12;
            };
            let v14 = if (arg1) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
            } else {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
            };
            v2 = v14;
        };
        v9
    }

    fun dlmm_total_fee_rate(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::BinStepConfig, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: u32) : u64 {
        let v0 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg2, arg3)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg2, arg3))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg3, arg2))
        };
        let v1 = (arg4 as u64) + (v0 as u64) * 10000;
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::max_volatility_accumulator(arg0);
        let v3 = if (v1 > (v2 as u64)) {
            v2
        } else {
            (v1 as u32)
        };
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::variable_fee_control(arg0);
        let v5 = if (v4 > 0) {
            let v6 = (v3 as u128) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(arg0) as u128);
            ((v4 as u128) * v6 * v6 + 99999999999) / 100000000000
        } else {
            0
        };
        let v7 = (arg1 as u128) + v5;
        let v8 = if (v7 > 100000000) {
            100000000
        } else {
            v7
        };
        (v8 as u64)
    }

    public fun magma_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = if (magma_quote_supported<T0, T1>(arg1, arg2)) {
                magma_out<T0, T1>(arg1, arg2, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0))
            } else {
                0
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, v1);
            v0 = v0 + 1;
        };
    }

    public fun magma_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = if (magma_quote_supported<T0, T1>(arg1, arg2)) {
                magma_out<T0, T1>(arg1, arg2, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0))
            } else {
                0
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, v1);
            v0 = v0 + 1;
        };
    }

    fun magma_out<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, true, arg3);
        if (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_is_exceed(&v0)) {
            0
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v0)
        }
    }

    fun magma_quote_supported<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : bool {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::default_unstaked_fee_rate();
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::unstaked_liquidity_fee_rate<T0, T1>(arg1);
        let v2 = if (v1 == v0) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::unstaked_liquidity_fee_rate(arg0)
        } else {
            v1
        };
        v2 == v0
    }

    fun scale_aftermath_expected_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    public fun suiswap_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, suiswap_out<T0, T1>(arg1, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun suiswap_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, suiswap_out<T0, T1>(arg1, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun suiswap_constant_product_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u128) * (arg1 as u128) / ((arg0 as u128) + (arg2 as u128))) as u64)
    }

    fun suiswap_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun suiswap_out<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_pool_type<T0, T1>(arg0) != 100) {
            return 0
        };
        if (0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_freeze<T0, T1>(arg0) & 1 != 0) {
            return 0
        };
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<T0, T1>(arg0);
        let (v3, v4) = if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        if (v3 == 0 || v4 == 0) {
            return 0
        };
        let v5 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0);
        let v6 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0);
        let v7 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0);
        let v8 = if (v5 >= 10000) {
            true
        } else if (v6 >= 10000) {
            true
        } else {
            v7 >= 10000
        };
        if (v8) {
            return 0
        };
        let v9 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_direction<T0, T1>(arg0);
        let v10 = v6 > 0 || v7 > 0;
        let v11 = if (v10) {
            if (v9 != 200) {
                v9 != 201
            } else {
                false
            }
        } else {
            false
        };
        if (v11) {
            return 0
        };
        let v12 = if (v10 && (arg1 && v9 == 200 || !(v9 == 200))) {
            let v13 = arg2 - suiswap_fee(arg2, v6);
            let v14 = v13 - suiswap_fee(v13, v7);
            let v15 = v14 - suiswap_fee(v14, v5);
            if (v15 == 0) {
                return 0
            };
            suiswap_constant_product_out(v3, v4, v15)
        } else {
            let v16 = arg2 - suiswap_fee(arg2, v5);
            if (v16 == 0) {
                return 0
            };
            let v17 = suiswap_constant_product_out(v3, v4, v16);
            let v18 = v17 - suiswap_fee(v17, v6);
            v18 - suiswap_fee(v18, v7)
        };
        if (v12 >= v4) {
            0
        } else {
            v12
        }
    }

    // decompiled from Move bytecode v7
}

