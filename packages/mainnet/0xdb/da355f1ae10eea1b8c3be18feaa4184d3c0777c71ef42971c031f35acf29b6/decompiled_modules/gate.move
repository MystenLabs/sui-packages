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
            let v10 = if (arg5) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg2, arg1, v9)
            } else {
                standard_health_factor(arg0, arg1, arg2, v9)
            };
            let v11 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v9);
            let v12 = v10 <= 1000000000000000000000000000 && v11;
            let (v13, v14) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, v9);
            let v15 = arg5 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_in_emode(arg2, v9);
            let v16 = if (v15) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_emode_id(arg2, v9)
            } else {
                0
            };
            0x1::vector::push_back<u256>(&mut v0, v10);
            0x1::vector::push_back<bool>(&mut v1, v11);
            0x1::vector::push_back<vector<u8>>(&mut v2, v13);
            0x1::vector::push_back<vector<u8>>(&mut v3, v14);
            let v17 = if (v12) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, v9)
            } else {
                0
            };
            0x1::vector::push_back<u256>(&mut v4, v17);
            let v18 = if (v12) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, v9)
            } else {
                0
            };
            0x1::vector::push_back<u256>(&mut v5, v18);
            0x1::vector::push_back<bool>(&mut v6, v15);
            0x1::vector::push_back<u64>(&mut v7, v16);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun can_liquidate_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: u256) : (vector<u256>, vector<bool>, vector<bool>, vector<vector<u8>>, vector<vector<u8>>, vector<u256>, vector<u256>) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor_batch(arg0, arg1, arg2, arg4);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg4)) {
            let v8 = *0x1::vector::borrow<address>(&arg4, v7);
            let v9 = *0x1::vector::borrow<u256>(&v0, v7);
            let (v10, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, v8);
            let v12 = v9 <= 1000000000000000000000000000 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v8);
            let v13 = if (v12) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, v8)
            } else {
                0
            };
            let v14 = if (v12) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, v8)
            } else {
                0
            };
            0x1::vector::push_back<bool>(&mut v1, v9 <= arg5);
            0x1::vector::push_back<bool>(&mut v2, v12);
            0x1::vector::push_back<vector<u8>>(&mut v3, v10);
            0x1::vector::push_back<vector<u8>>(&mut v4, v11);
            0x1::vector::push_back<u256>(&mut v5, v13);
            0x1::vector::push_back<u256>(&mut v6, v14);
            v7 = v7 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6)
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

