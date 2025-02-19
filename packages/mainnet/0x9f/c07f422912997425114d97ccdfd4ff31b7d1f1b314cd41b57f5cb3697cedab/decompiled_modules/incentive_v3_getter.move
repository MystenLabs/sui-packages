module 0x9fc07f422912997425114d97ccdfd4ff31b7d1f1b314cd41b57f5cb3697cedab::incentive_v3_getter {
    fun calculate_global_index(arg0: &0x2::clock::Clock, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule, arg2: u256, arg3: u256) : u256 {
        let (_, v1, _, _, v4, v5, v6, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_rule_info(arg1);
        let v10 = if (v1 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_supply()) {
            arg2
        } else {
            assert!(v1 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_borrow(), 0);
            arg3
        };
        let v11 = 0x2::clock::timestamp_ms(arg0) - v5;
        let v12 = if (v11 == 0 || v10 == 0) {
            0
        } else {
            v4 * (v11 as u256) / v10
        };
        v6 + v12
    }

    fun calculate_user_reward(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule, arg1: u256, arg2: address, arg3: u256, arg4: u256) : u256 {
        let (_, v1, _, _, _, _, _, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_rule_info(arg0);
        let v10 = if (v1 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_supply()) {
            arg3
        } else {
            assert!(v1 == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_borrow(), 0);
            arg4
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_total_rewards_by_rule(arg0, arg2) + 0x9fc07f422912997425114d97ccdfd4ff31b7d1f1b314cd41b57f5cb3697cedab::ray_math::ray_mul(v10, arg1 - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_index_by_rule(arg0, arg2))
    }

    public fun get_user_atomic_claimable_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: address) : (vector<0x1::ascii::String>, vector<0x1::ascii::String>, vector<u8>, vector<address>, vector<u256>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<u256>();
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::pools(arg2);
        let v6 = 0x2::vec_map::keys<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool>(v5);
        while (0x1::vector::length<0x1::ascii::String>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v6);
            let (_, v9, _, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_pool_info(0x2::vec_map::get<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool>(v5, &v7));
            let v12 = 0x2::vec_map::keys<address, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule>(v11);
            let (v13, v14, v15, v16) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_effective_balance(arg1, v9, arg3);
            while (0x1::vector::length<address>(&v12) > 0) {
                let v17 = 0x1::vector::pop_back<address>(&mut v12);
                let v18 = 0x2::vec_map::get<address, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule>(v11, &v17);
                let (_, v20, _, v22, _, _, _, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_rule_info(v18);
                let v29 = calculate_user_reward(v18, calculate_global_index(arg0, v18, v15, v16), arg3, v13, v14);
                let v30 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_rewards_claimed_by_rule(v18, arg3);
                let v31 = if (v29 > v30) {
                    v29 - v30
                } else {
                    0
                };
                if (v31 > 0) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v0, v7);
                    0x1::vector::push_back<0x1::ascii::String>(&mut v1, v22);
                    0x1::vector::push_back<u8>(&mut v2, v20);
                    0x1::vector::push_back<address>(&mut v3, v17);
                    0x1::vector::push_back<u256>(&mut v4, v31);
                };
            };
        };
        (v0, v1, v2, v3, v4)
    }

    public fun verify_rule_id_config<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg1: address, arg2: 0x1::ascii::String, arg3: u8, arg4: u8) {
        let (_, v1, _, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_pool_info(0x2::vec_map::get<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::pools(arg0), &arg2));
        assert!(v1 == arg3, 1);
        let (_, v5, _, v7, _, _, _, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_rule_info(0x2::vec_map::get<address, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule>(v3, &arg1));
        assert!(arg4 == v5, 2);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == v7, 3);
    }

    // decompiled from Move bytecode v6
}

