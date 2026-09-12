module 0x53beb15831b74948d79c4de8dd577cb4e41693ab287fcf8a05b6468ce032b03a::reader {
    struct Asset has copy, drop, store {
        asset_id: u8,
        is_collateral: bool,
        is_debt: bool,
        scaled_supply: u256,
        scaled_borrow: u256,
        supply_index: u256,
        borrow_index: u256,
        collateral: u256,
        debt: u256,
        price_usd_e8: u256,
        publish_time: u64,
        liquidation_threshold: u256,
        liquidation_ratio: u256,
        liquidation_bonus: u256,
        treasury_factor: u256,
        borrow_weight: u64,
    }

    struct Pair has copy, drop, store {
        debt_asset: u8,
        collateral_asset: u8,
        repay: u256,
        base_collateral: u256,
        executor_bonus: u256,
        treasury: u256,
        maximum_debt: bool,
    }

    struct Account has copy, drop, store {
        user: address,
        complete: bool,
        protocol_allowed: bool,
        is_in_emode: bool,
        emode_id: u64,
        health_factor: u256,
        collateral_usd_e9: u256,
        debt_usd_e9: u256,
        weighted_debt_usd_e9: u256,
        assets: vector<Asset>,
        pairs: vector<Pair>,
    }

    struct Batch has copy, drop, store {
        version: u8,
        clock_ms: u64,
        price_observed_at_ms: u64,
        accounts: vector<Account>,
    }

    struct OraclePrice has copy, drop, store {
        asset_id: u8,
        valid: bool,
        value: u256,
        decimals: u8,
        updated_at_ms: u64,
        valid_until_ms: u64,
    }

    struct DualBatch has copy, drop, store {
        local: Batch,
        onchain: Batch,
        oracle_prices: vector<OraclePrice>,
    }

    fun account(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: address, arg3: &vector<u8>, arg4: &vector<u256>, arg5: &vector<u64>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &vector<OraclePrice>) : Account {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg9, arg0, arg2);
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = arg8 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg0, arg2);
        let v5 = if (v4) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg0, arg2)
        } else {
            0
        };
        let v6 = &v2;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(v6)) {
            let v8 = 0x1::vector::borrow<u8>(v6, v7);
            if (!0x1::vector::contains<u8>(&v3, v8)) {
                0x1::vector::push_back<u8>(&mut v3, *v8);
            };
            v7 = v7 + 1;
        };
        let v9 = 0x1::vector::empty<Asset>();
        let v10 = true;
        let v11 = 0;
        let v12 = 0;
        let v13 = 0;
        let v14 = 0;
        0x1::vector::reverse<u8>(&mut v3);
        let v15 = 0;
        while (v15 < 0x1::vector::length<u8>(&v3)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut v3);
            let (v17, v18) = 0x1::vector::index_of<u8>(arg3, &v16);
            let v19 = if (v17) {
                *0x1::vector::borrow<u256>(arg4, v18)
            } else {
                0
            };
            let v20 = if (v17) {
                *0x1::vector::borrow<u64>(arg5, v18)
            } else {
                0
            };
            let v21 = (v20 as u256) * 1000;
            let v22 = if (v19 > 0) {
                if (v21 <= (arg6 as u256) + 1000) {
                    (arg6 as u256) <= v21 + (arg7 as u256)
                } else {
                    false
                }
            } else {
                false
            };
            let v23 = v22;
            if (!0x1::vector::is_empty<OraclePrice>(arg10)) {
                v23 = false;
                let v24 = 0;
                while (v24 < 0x1::vector::length<OraclePrice>(arg10)) {
                    let v25 = 0x1::vector::borrow<OraclePrice>(arg10, v24);
                    if (v25.asset_id == v16) {
                        v23 = v25.valid;
                    };
                    v24 = v24 + 1;
                };
            };
            let v26 = v10 && v23;
            v10 = v26;
            let (v27, v28) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v16, arg2);
            let (v29, v30) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, v16);
            let v31 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v27, v29);
            let v32 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v28, v30);
            let (v33, v34, v35) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg0, v16);
            let v36 = v35;
            let v37 = v34;
            if (v4) {
                let (_, v39, v40) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg0, v5, v16);
                v37 = v40;
                v36 = v39;
            };
            let v41 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_weight(arg0, v16);
            let v42 = 0x1::vector::contains<u8>(&v3, &v16);
            let v43 = 0x1::vector::contains<u8>(&v2, &v16);
            if (v23 && v42) {
                let v44 = asset_value(v31, v16, v19, arg10);
                v11 = v11 + v44;
                v12 = v12 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v44, v36);
            };
            if (v23 && v43) {
                let v45 = asset_value(v32, v16, v19, arg10);
                v13 = v13 + v45;
                v14 = v14 + v45 * (v41 as u256) / 10000;
            };
            let v46 = Asset{
                asset_id              : v16,
                is_collateral         : v42,
                is_debt               : v43,
                scaled_supply         : v27,
                scaled_borrow         : v28,
                supply_index          : v29,
                borrow_index          : v30,
                collateral            : v31,
                debt                  : v32,
                price_usd_e8          : v19,
                publish_time          : v20,
                liquidation_threshold : v36,
                liquidation_ratio     : v33,
                liquidation_bonus     : v37,
                treasury_factor       : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg0, v16),
                borrow_weight         : v41,
            };
            0x1::vector::push_back<Asset>(&mut v9, v46);
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<u8>(v3);
        let v47 = if (v11 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v12, v11)
        } else {
            0
        };
        let v48 = if (v10 && v14 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v11, v14), v47)
        } else {
            0x2::address::max()
        };
        let v49 = 0x1::vector::empty<Pair>();
        if (v10) {
            let v50 = &v9;
            let v51 = 0;
            while (v51 < 0x1::vector::length<Asset>(v50)) {
                let v52 = 0x1::vector::borrow<Asset>(v50, v51);
                if (v52.is_collateral && v52.collateral > 0) {
                    let v53 = &v9;
                    let v54 = 0;
                    while (v54 < 0x1::vector::length<Asset>(v53)) {
                        let v55 = 0x1::vector::borrow<Asset>(v53, v54);
                        let v56 = if (v55.is_debt) {
                            if (v55.debt > 0) {
                                v55.asset_id != v52.asset_id
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v56) {
                            0x1::vector::push_back<Pair>(&mut v49, pair(v55, v52, arg10));
                        };
                        v54 = v54 + 1;
                    };
                };
                v51 = v51 + 1;
            };
        };
        Account{
            user                 : arg2,
            complete             : v10,
            protocol_allowed     : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg0, arg1, arg2),
            is_in_emode          : v4,
            emode_id             : v5,
            health_factor        : v48,
            collateral_usd_e9    : v11,
            debt_usd_e9          : v13,
            weighted_debt_usd_e9 : v14,
            assets               : v9,
            pairs                : v49,
        }
    }

    fun asset_amount(arg0: u256, arg1: u8, arg2: u256, arg3: &vector<OraclePrice>) : u256 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<OraclePrice>(arg3)) {
            let v1 = 0x1::vector::borrow<OraclePrice>(arg3, v0);
            if (v1.asset_id == arg1) {
                return arg0 * (0x2::math::pow(10, v1.decimals) as u256) / v1.value
            };
            v0 = v0 + 1;
        };
        arg0 * 100000000 / arg2
    }

    fun asset_value(arg0: u256, arg1: u8, arg2: u256, arg3: &vector<OraclePrice>) : u256 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<OraclePrice>(arg3)) {
            let v1 = 0x1::vector::borrow<OraclePrice>(arg3, v0);
            if (v1.asset_id == arg1) {
                return arg0 * v1.value / (0x2::math::pow(10, v1.decimals) as u256)
            };
            v0 = v0 + 1;
        };
        arg0 * arg2 / 100000000
    }

    fun pair(arg0: &Asset, arg1: &Asset, arg2: &vector<OraclePrice>) : Pair {
        let v0 = asset_value(arg0.debt, arg0.asset_id, arg0.price_usd_e8, arg2);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(asset_value(arg1.collateral, arg1.asset_id, arg1.price_usd_e8, arg2), arg1.liquidation_ratio);
        let v2 = v1 >= v0;
        let v3 = if (v2) {
            v0
        } else {
            v1
        };
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v3, arg1.liquidation_bonus);
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v4, arg1.treasury_factor);
        Pair{
            debt_asset       : arg0.asset_id,
            collateral_asset : arg1.asset_id,
            repay            : asset_amount(v3, arg0.asset_id, arg0.price_usd_e8, arg2),
            base_collateral  : asset_amount(v3, arg1.asset_id, arg1.price_usd_e8, arg2),
            executor_bonus   : asset_amount(v4 - v5, arg1.asset_id, arg1.price_usd_e8, arg2),
            treasury         : asset_amount(v5, arg1.asset_id, arg1.price_usd_e8, arg2),
            maximum_debt     : v2,
        }
    }

    public fun pool_cash<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : u64 {
        let v0 = 0x1::bcs::to_bytes<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 49, 1);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1)
    }

    public fun snapshot(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: vector<address>, arg3: vector<u8>, arg4: vector<u256>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock) : Batch {
        let v0 = 0x1::vector::length<u8>(&arg3);
        let v1 = if (v0 == 0x1::vector::length<u256>(&arg4)) {
            if (v0 == 0x1::vector::length<u64>(&arg5)) {
                if (0x1::vector::length<address>(&arg2) <= 64) {
                    if (arg7 > 0) {
                        arg7 <= 10000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 1;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u8>(&arg3, v2 - 1) < *0x1::vector::borrow<u8>(&arg3, v2), 1);
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::empty<Account>();
        0x1::vector::reverse<address>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg2)) {
            let v5 = 0x1::vector::empty<OraclePrice>();
            0x1::vector::push_back<Account>(&mut v3, account(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), &arg3, &arg4, &arg5, arg6, arg7, arg8, arg9, &v5));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        Batch{
            version              : 1,
            clock_ms             : 0x2::clock::timestamp_ms(arg9),
            price_observed_at_ms : arg6,
            accounts             : v3,
        }
    }

    public fun snapshot_dual(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: vector<address>, arg3: vector<u8>, arg4: vector<u256>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) : DualBatch {
        let v0 = snapshot(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x1::bcs::to_bytes<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg10);
        assert!(0x1::vector::length<u8>(&v1) == 88, 1);
        let v2 = 0x2::bcs::new(v1);
        0x2::bcs::peel_address(&mut v2);
        0x2::bcs::peel_u64(&mut v2);
        let v3 = b"";
        let v4 = &v0.accounts;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Account>(v4)) {
            let v6 = &0x1::vector::borrow<Account>(v4, v5).assets;
            let v7 = 0;
            while (v7 < 0x1::vector::length<Asset>(v6)) {
                let v8 = 0x1::vector::borrow<Asset>(v6, v7);
                if (!0x1::vector::contains<u8>(&v3, &v8.asset_id)) {
                    0x1::vector::push_back<u8>(&mut v3, v8.asset_id);
                };
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
        let v9 = 0x1::vector::empty<OraclePrice>();
        let v10 = vector[];
        let v11 = vector[];
        let v12 = &v3;
        let v13 = 0;
        while (v13 < 0x1::vector::length<u8>(v12)) {
            let v14 = 0x1::vector::borrow<u8>(v12, v13);
            let v15 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg0, *v14);
            let v16 = 0x1::bcs::to_bytes<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::Price>(0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::price_object(arg10, v15));
            assert!(0x1::vector::length<u8>(&v16) == 41, 1);
            let v17 = 0x2::bcs::new(v16);
            let v18 = 0x2::bcs::peel_u256(&mut v17);
            let v19 = 0x2::bcs::peel_u8(&mut v17);
            let v20 = 0x2::bcs::peel_u64(&mut v17);
            let v21 = if (v20 <= 0x2::clock::timestamp_ms(arg9)) {
                let (v22, _, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg9, arg10, v15);
                v22
            } else {
                false
            };
            0x1::vector::push_back<u256>(&mut v10, v18 * 100000000 / (0x2::math::pow(10, v19) as u256));
            0x1::vector::push_back<u64>(&mut v11, v20 / 1000);
            let v25 = OraclePrice{
                asset_id       : *v14,
                valid          : v21,
                value          : v18,
                decimals       : v19,
                updated_at_ms  : v20,
                valid_until_ms : v20 + 0x2::bcs::peel_u64(&mut v2),
            };
            0x1::vector::push_back<OraclePrice>(&mut v9, v25);
            v13 = v13 + 1;
        };
        let v26 = 0x1::vector::empty<Account>();
        0x1::vector::reverse<address>(&mut arg2);
        let v27 = 0;
        while (v27 < 0x1::vector::length<address>(&arg2)) {
            0x1::vector::push_back<Account>(&mut v26, account(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), &v3, &v10, &v11, arg6, arg7, arg8, arg9, &v9));
            v27 = v27 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        let v28 = Batch{
            version              : 1,
            clock_ms             : 0x2::clock::timestamp_ms(arg9),
            price_observed_at_ms : arg6,
            accounts             : v26,
        };
        DualBatch{
            local         : v0,
            onchain       : v28,
            oracle_prices : v9,
        }
    }

    // decompiled from Move bytecode v7
}

