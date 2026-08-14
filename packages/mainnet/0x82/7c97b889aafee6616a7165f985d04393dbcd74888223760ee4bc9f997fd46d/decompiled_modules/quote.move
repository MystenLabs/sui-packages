module 0xf97d897e8e5cbf3d4087a1ba94922a53c1e5f7f2d7acf48bf811ddaa4652af8a::quote {
    public fun aftermath_lp_a2b<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: u64, arg3: u8) {
        assert!(arg2 > 0, 402);
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T2, T0, T1>(arg1, v1, arg2, 0)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun aftermath_lp_b2a<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: u64, arg3: u8) {
        assert!(arg2 > 0, 402);
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T2, T1, T0>(arg1, v1, arg2, 0)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun alphafi_stsui_mint<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<T0>(arg1, v1)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun alphafi_stsui_redeem<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0 || 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<T0>(arg1) == 0) {
                0
            } else {
                0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<T0>(arg1, v1)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun bayswap_a2b<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: u8) {
        bayswap_record<T0, T1, T2>(arg0, arg1, true, arg2);
    }

    public fun bayswap_b2a<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: u8) {
        bayswap_record<T0, T1, T2>(arg0, arg1, false, arg2);
    }

    fun bayswap_pool_locked<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>) : bool {
        let v0 = 0x2::bcs::to_bytes<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 89, 403);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_bool(&mut v1)
    }

    fun bayswap_record<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: bool, arg3: u8) {
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T0, T1, T2>(arg1);
        let (v1, v2, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T0, T1, T2>(v0);
        let v4 = if (arg2) {
            v2
        } else {
            v1
        };
        let v5 = 0;
        while (v5 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v6 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v5);
            let v7 = if (bayswap_pool_locked<T0, T1, T2>(v0)) {
                true
            } else if (v6 == 0) {
                true
            } else if (v1 == 0) {
                true
            } else {
                v2 == 0
            };
            let v8 = if (v7) {
                0
            } else {
                let v9 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::get_amount_out<T0, T1, T2>(v0, v6, arg2);
                if (v9 >= v4) {
                    0
                } else {
                    v9
                }
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v5, v8);
            v5 = v5 + 1;
        };
    }

    public fun bluemove_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: u64, arg2: u8) {
        bluemove_record(arg0, arg1, arg2);
    }

    public fun bluemove_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: u64, arg2: u8) {
        bluemove_record(arg0, arg1, arg2);
    }

    fun bluemove_record(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: u64, arg2: u8) {
        assert!(arg1 > 0, 402);
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, scale_expected_out(arg1, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0), 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, 0)));
            v0 = v0 + 1;
        };
    }

    fun ceil_bps_fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = (10000 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    fun floor_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun hasui_mint(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v1)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun hasui_redeem(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v1 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg1, v1);
                if (v3 > 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_total_sui(arg1) || v3 < 1000000000) {
                    0
                } else {
                    v3 - (((v3 as u128) * (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_service_fee(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_config_mut(arg1)) as u128) / 10000000) as u64)
                }
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, v2);
            v0 = v0 + 1;
        };
    }

    fun scale_expected_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    fun scallop_balance_sheet<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::get<T0>()))
    }

    public fun scallop_mint<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: u8) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg1, arg2, arg3);
        let (v0, v1, v2, v3) = scallop_balance_sheet<T1>(arg2);
        let v4 = scallop_total_underlying(v0, v1, v2);
        let v5 = 0;
        while (v5 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v6 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v5);
            let v7 = if (v6 == 0) {
                0
            } else if (v3 == 0) {
                v6
            } else if (v4 == 0) {
                0
            } else {
                floor_mul_div(v6, v3, v4)
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg4, v5, v7);
            v5 = v5 + 1;
        };
    }

    public fun scallop_redeem<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: u8) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg1, arg2, arg3);
        let (v0, v1, v2, v3) = scallop_balance_sheet<T1>(arg2);
        let v4 = 0;
        while (v4 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v5 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v4);
            let v6 = if (v5 == 0 || v3 == 0) {
                0
            } else {
                let v7 = floor_mul_div(v5, scallop_total_underlying(v0, v1, v2), v3);
                if (v7 > v0) {
                    0
                } else {
                    v7
                }
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg4, v4, v6);
            v4 = v4 + 1;
        };
    }

    fun scallop_total_underlying(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 - arg2
    }

    public fun spring_sui_mint<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: u8) {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg1);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg1);
        let v2 = 0;
        while (v2 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v3 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v2);
            let v4 = if (v3 == 0) {
                0
            } else {
                let v5 = ceil_bps_fee(v3, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::sui_mint_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg1)));
                if (v5 >= v3) {
                    0
                } else if (v0 == 0 || v1 == 0) {
                    v3 - v5
                } else {
                    floor_mul_div(v3 - v5, v1, v0)
                }
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v2, v4);
            v2 = v2 + 1;
        };
    }

    public fun spring_sui_redeem<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: u8) {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg1);
        let v1 = 0;
        while (v1 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v1);
            let v3 = if (v2 == 0 || v0 == 0) {
                0
            } else {
                let v4 = floor_mul_div(v2, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg1), v0);
                let v5 = ceil_bps_fee(v4, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::redeem_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg1)));
                if (v5 >= v4) {
                    0
                } else {
                    v4 - v5
                }
            };
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v1, v3);
            v1 = v1 + 1;
        };
    }

    public fun suidex_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, suidex_out<T0, T1>(arg1, arg2, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun suidex_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, suidex_out<T0, T1>(arg1, arg2, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun suidex_out<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg2: bool, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        (0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::library::get_amounts_out<T0, T1>(arg0, (arg3 as u256), arg1, arg2) as u64)
    }

    fun volo_out(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: u64, arg3: bool) : u64 {
        if (arg2 == 0) {
            return 0
        };
        0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::get_amount_out(arg0, arg1, arg2, arg3)
    }

    public fun volo_stake(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, volo_out(arg1, arg2, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0), true));
            v0 = v0 + 1;
        };
    }

    public fun volo_unstake(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg3, v0, volo_out(arg1, arg2, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0), false));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

