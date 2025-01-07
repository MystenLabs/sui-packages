module 0x9e5758d067f974dc0f69b3dc1ec0dd2769bddd74c955de68a1ad6c56082980a0::l {
    fun get_liquidable_debtors_with_info_under_normal_mode<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : (u64, u64, vector<address>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(arg0);
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_collateral_vault_balance<T0>(arg0);
        while (0x1::option::is_some<address>(&v2)) {
            let v5 = 0x1::option::destroy_some<address>(v2);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_healthy_bottle_by_debtor<T0>(arg0, arg1, arg2, v5)) {
                break
            };
            let (v6, v7) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(arg0, v5, arg2);
            if (v4 < v6) {
                break
            };
            v0 = v0 + v7;
            v1 = v1 + v6;
            v4 = v4 - v6;
            0x1::vector::push_back<address>(&mut v3, v5);
            v2 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(arg0, v5);
        };
        0x1::vector::reverse<address>(&mut v3);
        (v0, v1, v3)
    }

    fun get_liquidable_debtors_with_info_under_recovery_mode<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : (u64, u64, vector<address>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(arg0);
        let v3 = 0x1::vector::empty<address>();
        let (v4, v5) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let v6 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bucket_debt<T0>(arg0, arg2);
        let v7 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_total_collateral_balance<T0>(arg0);
        let v8 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_collateral_vault_balance<T0>(arg0);
        let v9 = true;
        while (0x1::option::is_some<address>(&v2)) {
            let v10 = 0x1::option::destroy_some<address>(v2);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_healthy_bottle_by_debtor<T0>(arg0, arg1, arg2, v10)) {
                break
            };
            if (v9) {
                let (v11, v12) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(arg0, v10, arg2);
                if (v8 < v11) {
                    break
                };
                v0 = v0 + v12;
                v1 = v1 + v11;
                v8 = v8 - v11;
                v6 = v6 - v12;
                v7 = v7 - v11;
                v9 = is_in_recovery_mode_by_value(150, v6, v7, v4, v5);
            } else {
                let (v13, v14) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(arg0, v10, arg2);
                if (v8 < v13) {
                    break
                };
                if (is_under_collateralized_by_value(110, v14, v13, v4, v5)) {
                    v0 = v0 + v14;
                    v1 = v1 + v13;
                    v8 = v8 - v13;
                } else {
                    break
                };
            };
            0x1::vector::push_back<address>(&mut v3, v10);
            v2 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(arg0, v10);
        };
        0x1::vector::reverse<address>(&mut v3);
        (v0, v1, v3)
    }

    public(friend) fun gl<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : (u64, u64, vector<address>) {
        if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(arg0, arg1, arg2)) {
            return get_liquidable_debtors_with_info_under_recovery_mode<T0>(arg0, arg1, arg2)
        };
        get_liquidable_debtors_with_info_under_normal_mode<T0>(arg0, arg1, arg2)
    }

    fun is_in_recovery_mode_by_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg2, arg3, arg4) <= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, arg0, 100)
    }

    fun is_under_collateralized_by_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg2, arg3, arg4) < 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, arg0, 100)
    }

    // decompiled from Move bytecode v6
}

