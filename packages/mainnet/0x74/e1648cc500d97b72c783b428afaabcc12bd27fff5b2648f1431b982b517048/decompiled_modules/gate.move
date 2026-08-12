module 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::gate {
    public fun account_snapshot_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: bool) : (vector<u256>, vector<bool>, vector<vector<u8>>, vector<vector<u8>>, vector<u256>, vector<u256>, vector<bool>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&arg4)) {
            let v9 = *0x1::vector::borrow<address>(&arg4, v8);
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg0, arg2, v9);
            let v10 = if (arg5) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg2, arg1, v9)
            } else {
                standard_health_factor(arg0, arg1, arg2, v9)
            };
            let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, v9);
            let v13 = arg5 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg2, v9);
            let v14 = if (v13) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg2, v9)
            } else {
                0
            };
            0x1::vector::push_back<u256>(&mut v0, v10);
            0x1::vector::push_back<bool>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v9));
            0x1::vector::push_back<vector<u8>>(&mut v2, v11);
            0x1::vector::push_back<vector<u8>>(&mut v3, v12);
            0x1::vector::push_back<u256>(&mut v4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, v9));
            0x1::vector::push_back<u256>(&mut v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, v9));
            0x1::vector::push_back<bool>(&mut v6, v13);
            0x1::vector::push_back<u64>(&mut v7, v14);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    fun best_liquidation_plan(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: bool) : (bool, u8, u8, u256, u256, u256, u256, u256, u256, u256, u256, u256, u256, bool) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = arg4 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg2, arg3);
        let v5 = false;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = false;
        let v19 = 0;
        let v20 = 0;
        while (v20 < 0x1::vector::length<u8>(&v3)) {
            let v21 = *0x1::vector::borrow<u8>(&v3, v20);
            let v22 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v21, arg3);
            let (v23, v24, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, v21);
            let v26 = v24;
            if (v4) {
                let (_, _, v29) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg2, arg3), v21);
                v26 = v29;
            };
            let v30 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg2, v21);
            let v31 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, v21);
            let v32 = 0;
            while (v32 < 0x1::vector::length<u8>(&v2)) {
                let v33 = *0x1::vector::borrow<u8>(&v2, v32);
                if (v33 != v21 && v22 > 0) {
                    let v34 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, v33, arg3);
                    if (v34 > 0) {
                        let (v35, v36, v37, v38, v39, v40) = preview_pair(arg0, arg1, arg2, v33, v21, v34, v34, v22, v23, v26, v30);
                        if (v35 > 0 && v36 + v37 > 0) {
                            let v41 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, v37, v31);
                            let v42 = if (!v5) {
                                true
                            } else if (v41 > v19) {
                                true
                            } else {
                                v41 == v19 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, v35, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, v33)) > 0
                            };
                            if (v42) {
                                v5 = true;
                                v6 = v33;
                                v7 = v21;
                                v8 = v34;
                                v9 = v22;
                                v10 = v23;
                                v11 = v26;
                                v12 = v30;
                                v13 = v35;
                                v14 = v36;
                                v15 = v37;
                                v16 = v38;
                                v17 = v39;
                                v18 = v40;
                            };
                        };
                    };
                };
                v32 = v32 + 1;
            };
            v20 = v20 + 1;
        };
        (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)
    }

    public fun can_liquidate_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: u256) : (vector<u256>, vector<bool>, vector<bool>, vector<vector<u8>>, vector<vector<u8>>, vector<u256>, vector<u256>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg0, arg2, *0x1::vector::borrow<address>(&arg4, v0));
            v0 = v0 + 1;
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor_batch(arg0, arg1, arg2, arg4);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&arg4)) {
            let v9 = *0x1::vector::borrow<address>(&arg4, v8);
            let v10 = *0x1::vector::borrow<u256>(&v1, v8);
            let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, v9);
            let v13 = v10 <= 1000000000000000000000000000 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v9);
            let v14 = if (v13) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, v9)
            } else {
                0
            };
            let v15 = if (v13) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, v9)
            } else {
                0
            };
            0x1::vector::push_back<bool>(&mut v2, v10 <= arg5);
            0x1::vector::push_back<bool>(&mut v3, v13);
            0x1::vector::push_back<vector<u8>>(&mut v4, v11);
            0x1::vector::push_back<vector<u8>>(&mut v5, v12);
            0x1::vector::push_back<u256>(&mut v6, v14);
            0x1::vector::push_back<u256>(&mut v7, v15);
            v8 = v8 + 1;
        };
        (v1, v2, v3, v4, v5, v6, v7)
    }

    public fun exact_pair_repay_raw(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: address, arg5: u8, arg6: u8, arg7: u8, arg8: u64, arg9: bool) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg0, arg2, arg4);
        let v0 = if (arg9) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg2, arg1, arg4)
        } else {
            standard_health_factor(arg0, arg1, arg2, arg4)
        };
        if (v0 > 1000000000000000000000000000 || !0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, arg4)) {
            return 0
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, arg5, arg4);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg6, arg4);
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        let (v3, v4, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, arg6);
        let v6 = v4;
        if (arg9 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg2, arg4)) {
            let (_, _, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg2, arg4), arg6);
            v6 = v9;
        };
        let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg2, arg6);
        let (v11, _, _, _, _, _) = preview_pair(arg0, arg1, arg2, arg5, arg6, v1, v1, v2, v3, v6, v10);
        normalized_repay_to_capped_raw(v11, arg7, arg8)
    }

    public fun hot_account_state_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: bool) : (vector<u256>, vector<bool>, vector<vector<u8>>, vector<vector<u8>>, vector<u256>, vector<u256>, vector<bool>, vector<u64>, vector<vector<u8>>, vector<vector<u256>>, vector<vector<u256>>, vector<vector<u256>>, vector<vector<u256>>) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = account_snapshot_batch(arg0, arg1, arg2, arg3, arg4, arg5);
        let v8 = v3;
        let v9 = v2;
        let v10 = v1;
        let v11 = vector[];
        let v12 = vector[];
        let v13 = vector[];
        let v14 = vector[];
        let v15 = vector[];
        let v16 = 0;
        while (v16 < 0x1::vector::length<address>(&arg4)) {
            let v17 = *0x1::vector::borrow<address>(&arg4, v16);
            let v18 = b"";
            if (*0x1::vector::borrow<bool>(&v10, v16)) {
                let v19 = 0x1::vector::borrow<vector<u8>>(&v9, v16);
                let v20 = 0;
                while (v20 < 0x1::vector::length<u8>(v19)) {
                    0x1::vector::push_back<u8>(&mut v18, *0x1::vector::borrow<u8>(v19, v20));
                    v20 = v20 + 1;
                };
                let v21 = 0x1::vector::borrow<vector<u8>>(&v8, v16);
                v20 = 0;
                while (v20 < 0x1::vector::length<u8>(v21)) {
                    let v22 = *0x1::vector::borrow<u8>(v21, v20);
                    if (!0x1::vector::contains<u8>(&v18, &v22)) {
                        0x1::vector::push_back<u8>(&mut v18, v22);
                    };
                    v20 = v20 + 1;
                };
            };
            let v23 = vector[];
            let v24 = vector[];
            let v25 = vector[];
            let v26 = vector[];
            let v27 = 0;
            while (v27 < 0x1::vector::length<u8>(&v18)) {
                let v28 = *0x1::vector::borrow<u8>(&v18, v27);
                let (v29, v30) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg2, v28, v17);
                0x1::vector::push_back<u256>(&mut v23, v29);
                0x1::vector::push_back<u256>(&mut v24, v30);
                0x1::vector::push_back<u256>(&mut v25, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v28, v17));
                0x1::vector::push_back<u256>(&mut v26, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, v28, v17));
                v27 = v27 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v11, v18);
            0x1::vector::push_back<vector<u256>>(&mut v12, v23);
            0x1::vector::push_back<vector<u256>>(&mut v13, v24);
            0x1::vector::push_back<vector<u256>>(&mut v14, v25);
            0x1::vector::push_back<vector<u256>>(&mut v15, v26);
            v16 = v16 + 1;
        };
        (v0, v10, v9, v8, v4, v5, v6, v7, v11, v12, v13, v14, v15)
    }

    public fun liquidation_pair_preview_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: vector<address>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u256>, arg7: bool) : (vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<bool>) {
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(0x1::vector::length<u8>(&arg4) == v0, 0);
        assert!(0x1::vector::length<u8>(&arg5) == v0, 0);
        assert!(0x1::vector::length<u256>(&arg6) == v0, 0);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = 0;
        while (v12 < v0) {
            let v13 = *0x1::vector::borrow<address>(&arg3, v12);
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg0, arg2, v13);
            let v14 = *0x1::vector::borrow<u8>(&arg4, v12);
            let v15 = *0x1::vector::borrow<u8>(&arg5, v12);
            let v16 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, v14, v13);
            let v17 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v15, v13);
            let (v18, v19, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, v15);
            let v21 = v19;
            if (arg7 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg2, v13)) {
                let (_, _, v24) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_emode_asset_info(arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg2, v13), v15);
                v21 = v24;
            };
            let v25 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg2, v15);
            let (v26, v27, v28, v29, v30, v31) = preview_pair(arg0, arg1, arg2, v14, v15, *0x1::vector::borrow<u256>(&arg6, v12), v16, v17, v18, v21, v25);
            0x1::vector::push_back<u256>(&mut v1, v16);
            0x1::vector::push_back<u256>(&mut v2, v17);
            0x1::vector::push_back<u256>(&mut v3, v18);
            0x1::vector::push_back<u256>(&mut v4, v21);
            0x1::vector::push_back<u256>(&mut v5, v25);
            0x1::vector::push_back<u256>(&mut v6, v26);
            0x1::vector::push_back<u256>(&mut v7, v27);
            0x1::vector::push_back<u256>(&mut v8, v28);
            0x1::vector::push_back<u256>(&mut v9, v29);
            0x1::vector::push_back<u256>(&mut v10, v30);
            0x1::vector::push_back<bool>(&mut v11, v31);
            v12 = v12 + 1;
        };
        (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    public fun liquidation_plan_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: u256, arg6: bool) : (vector<u256>, vector<bool>, vector<bool>, vector<bool>, vector<bool>, vector<u8>, vector<u8>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<u256>, vector<bool>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg4);
        while (v0 < v1) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::update_state_of_user(arg0, arg2, *0x1::vector::borrow<address>(&arg4, v0));
            v0 = v0 + 1;
        };
        let v2 = if (arg6) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor_batch(arg0, arg1, arg2, arg4)
        } else {
            let v3 = vector[];
            let v4 = 0;
            while (v4 < v1) {
                let v5 = standard_health_factor(arg0, arg1, arg2, *0x1::vector::borrow<address>(&arg4, v4));
                0x1::vector::push_back<u256>(&mut v3, v5);
                v4 = v4 + 1;
            };
            v3
        };
        let v6 = v2;
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = b"";
        let v12 = b"";
        let v13 = vector[];
        let v14 = vector[];
        let v15 = vector[];
        let v16 = vector[];
        let v17 = vector[];
        let v18 = vector[];
        let v19 = vector[];
        let v20 = vector[];
        let v21 = vector[];
        let v22 = vector[];
        let v23 = vector[];
        let v24 = 0;
        while (v24 < v1) {
            let v25 = *0x1::vector::borrow<address>(&arg4, v24);
            let v26 = *0x1::vector::borrow<u256>(&v6, v24);
            let v27 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v25);
            let v28 = v26 <= 1000000000000000000000000000 && v27;
            let (v29, v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42) = if (v28) {
                let (v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56) = best_liquidation_plan(arg0, arg1, arg2, v25, arg6);
                (v50, v51, v52, v53, v54, v55, v56, v43, v44, v45, v46, v47, v48, v49)
            } else {
                (0, 0, 0, 0, 0, 0, false, false, 0, 0, 0, 0, 0, 0)
            };
            0x1::vector::push_back<bool>(&mut v7, v26 <= arg5);
            0x1::vector::push_back<bool>(&mut v8, v27);
            0x1::vector::push_back<bool>(&mut v9, v28);
            0x1::vector::push_back<bool>(&mut v10, v36);
            0x1::vector::push_back<u8>(&mut v11, v37);
            0x1::vector::push_back<u8>(&mut v12, v38);
            0x1::vector::push_back<u256>(&mut v13, v39);
            0x1::vector::push_back<u256>(&mut v14, v40);
            0x1::vector::push_back<u256>(&mut v15, v41);
            0x1::vector::push_back<u256>(&mut v16, v42);
            0x1::vector::push_back<u256>(&mut v17, v29);
            0x1::vector::push_back<u256>(&mut v18, v30);
            0x1::vector::push_back<u256>(&mut v19, v31);
            0x1::vector::push_back<u256>(&mut v20, v32);
            0x1::vector::push_back<u256>(&mut v21, v33);
            0x1::vector::push_back<u256>(&mut v22, v34);
            0x1::vector::push_back<bool>(&mut v23, v35);
            v24 = v24 + 1;
        };
        (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23)
    }

    fun normalized_repay_to_capped_raw(arg0: u256, arg1: u8, arg2: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        if (arg1 <= 9) {
            while (v1 < 9 - arg1) {
                v0 = v0 * 10;
                v1 = v1 + 1;
            };
            let v3 = if (arg0 == 0) {
                0
            } else {
                (arg0 - 1) / v0 + 1
            };
            if (v3 > (arg2 as u256)) {
                arg2
            } else {
                (v3 as u64)
            }
        } else {
            while (v1 < arg1 - 9) {
                v0 = v0 * 10;
                v1 = v1 + 1;
            };
            let v4 = arg0 * v0;
            if (v4 > (arg2 as u256)) {
                arg2
            } else {
                (v4 as u64)
            }
        }
    }

    fun preview_pair(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u8, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) : (u256, u256, u256, u256, u256, bool) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg4);
        let (v2, v3, v4, v5, v6) = preview_values(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, arg6, v0), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, arg7, v1), arg8), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg0, arg1, arg5, v0), arg9, arg10);
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v2, v0), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v2, v1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v3, v1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v4, v1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v5, v0), v6)
    }

    fun preview_values(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256, u256, u256, bool) {
        let v0 = arg1;
        let v1 = false;
        let v2 = if (arg2 >= arg1) {
            arg2 - arg1
        } else {
            v0 = arg2;
            0
        };
        if (v0 >= arg0) {
            v1 = true;
            v0 = arg0;
            v2 = arg2 - arg0;
        };
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v0, arg3);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v3, arg4);
        (v0, v3 - v4, v4, v2, v1)
    }

    fun standard_health_factor(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, arg3);
        let v2 = v0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v2)) {
            let v6 = *0x1::vector::borrow<u8>(&v2, v5);
            let (_, _, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, v6);
            let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg1, arg2, v6, arg3);
            v4 = v4 + 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v10, v9);
            v3 = v3 + v10;
            v5 = v5 + 1;
        };
        let v11 = if (v3 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v4, v3)
        } else {
            0
        };
        let v12 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::weighted_user_health_loan_value(arg0, arg1, arg2, arg3);
        if (v12 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(v3, v12), v11)
        } else {
            0x2::address::max()
        }
    }

    // decompiled from Move bytecode v7
}

