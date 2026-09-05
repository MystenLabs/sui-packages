module 0xf793630a0824ac52b528910e59850d650419fc1ce532ced77ec0ce8adb76fd9b::reader {
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

    fun account(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: address, arg3: &vector<u8>, arg4: &vector<u256>, arg5: &vector<u64>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock) : Account {
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
            let v23 = v10 && v22;
            v10 = v23;
            let (v24, v25) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v16, arg2);
            let (v26, v27) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, v16);
            let v28 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v24, v26);
            let v29 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v25, v27);
            let (v30, v31, v32) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg0, v16);
            let v33 = v32;
            let v34 = v31;
            if (v4) {
                let (_, v36, v37) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg0, v5, v16);
                v34 = v37;
                v33 = v36;
            };
            let v38 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_weight(arg0, v16);
            let v39 = 0x1::vector::contains<u8>(&v3, &v16);
            let v40 = 0x1::vector::contains<u8>(&v2, &v16);
            if (v22 && v39) {
                let v41 = v28 * v19 / 100000000;
                v11 = v11 + v41;
                v12 = v12 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v41, v33);
            };
            if (v22 && v40) {
                let v42 = v29 * v19 / 100000000;
                v13 = v13 + v42;
                v14 = v14 + v42 * (v38 as u256) / 10000;
            };
            let v43 = Asset{
                asset_id              : v16,
                is_collateral         : v39,
                is_debt               : v40,
                scaled_supply         : v24,
                scaled_borrow         : v25,
                supply_index          : v26,
                borrow_index          : v27,
                collateral            : v28,
                debt                  : v29,
                price_usd_e8          : v19,
                publish_time          : v20,
                liquidation_threshold : v33,
                liquidation_ratio     : v30,
                liquidation_bonus     : v34,
                treasury_factor       : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg0, v16),
                borrow_weight         : v38,
            };
            0x1::vector::push_back<Asset>(&mut v9, v43);
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<u8>(v3);
        let v44 = if (v11 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v12, v11)
        } else {
            0
        };
        let v45 = if (v10 && v14 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v11, v14), v44)
        } else {
            0x2::address::max()
        };
        let v46 = 0x1::vector::empty<Pair>();
        if (v10) {
            let v47 = &v9;
            let v48 = 0;
            while (v48 < 0x1::vector::length<Asset>(v47)) {
                let v49 = 0x1::vector::borrow<Asset>(v47, v48);
                if (v49.is_collateral && v49.collateral > 0) {
                    let v50 = &v9;
                    let v51 = 0;
                    while (v51 < 0x1::vector::length<Asset>(v50)) {
                        let v52 = 0x1::vector::borrow<Asset>(v50, v51);
                        let v53 = if (v52.is_debt) {
                            if (v52.debt > 0) {
                                v52.asset_id != v49.asset_id
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v53) {
                            0x1::vector::push_back<Pair>(&mut v46, pair(v52, v49));
                        };
                        v51 = v51 + 1;
                    };
                };
                v48 = v48 + 1;
            };
        };
        Account{
            user                 : arg2,
            complete             : v10,
            protocol_allowed     : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg0, arg1, arg2),
            is_in_emode          : v4,
            emode_id             : v5,
            health_factor        : v45,
            collateral_usd_e9    : v11,
            debt_usd_e9          : v13,
            weighted_debt_usd_e9 : v14,
            assets               : v9,
            pairs                : v46,
        }
    }

    fun pair(arg0: &Asset, arg1: &Asset) : Pair {
        let v0 = arg0.debt * arg0.price_usd_e8 / 100000000;
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(arg1.collateral * arg1.price_usd_e8 / 100000000, arg1.liquidation_ratio);
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
            repay            : v3 * 100000000 / arg0.price_usd_e8,
            base_collateral  : v3 * 100000000 / arg1.price_usd_e8,
            executor_bonus   : (v4 - v5) * 100000000 / arg1.price_usd_e8,
            treasury         : v5 * 100000000 / arg1.price_usd_e8,
            maximum_debt     : v2,
        }
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
            0x1::vector::push_back<Account>(&mut v3, account(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), &arg3, &arg4, &arg5, arg6, arg7, arg8, arg9));
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

    // decompiled from Move bytecode v7
}

