module 0x1e0e1a1ba5fcdc824c8f4fd3bc2fa7cc817717e5ec51c088f6f0ff13260434c2::liquidate {
    struct DebtorInfo has copy, drop {
        debtor: address,
        collateral: u64,
        debt: u64,
        price: u64,
        precision: u64,
    }

    public fun emit_debtor_info<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: address, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(arg0, arg2, arg3);
        let (v2, v3) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg3);
        let v4 = DebtorInfo{
            debtor     : arg2,
            collateral : v0,
            debt       : v1,
            price      : v2,
            precision  : v3,
        };
        0x2::event::emit<DebtorInfo>(v4);
    }

    public fun emit_lowerst_cr_debtor_info<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(arg0);
        if (0x1::option::is_some<address>(&v0)) {
            emit_debtor_info<T0>(arg0, arg1, 0x1::option::destroy_some<address>(v0), arg2);
        };
    }

    public fun get_liquidable_debtors<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : vector<address> {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(arg0);
        let v1 = 0x1::vector::empty<address>();
        while (0x1::option::is_some<address>(&v0)) {
            let v2 = 0x1::option::destroy_some<address>(v0);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_healthy_bottle_by_debtor<T0>(arg0, arg1, arg2, v2)) {
                break
            };
            0x1::vector::push_back<address>(&mut v1, v2);
            v0 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(arg0, v2);
        };
        0x1::vector::reverse<address>(&mut v1);
        v1
    }

    public fun get_liquidable_debtors_with_info<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : (u64, u64, vector<address>) {
        if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(arg0, arg1, arg2)) {
            return get_liquidable_debtors_with_info_under_recovery_mode<T0>(arg0, arg1, arg2)
        };
        get_liquidable_debtors_with_info_under_normal_mode<T0>(arg0, arg1, arg2)
    }

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
                v9 = is_in_recovery_mode_by_value(v6, v7, v4, v5);
            } else {
                let (v13, v14) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(arg0, v10, arg2);
                if (v8 < v13) {
                    break
                };
                if (is_under_collateralized_by_value(v14, v13, v4, v5)) {
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

    fun is_in_recovery_mode_by_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, arg2, arg3) <= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, 150, 100)
    }

    fun is_under_collateralized_by_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, arg2, arg3) < 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, 110, 100)
    }

    public entry fun liquidate_after_price_update<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_normal_mode<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0)))), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun liquidate_debtors<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: vector<address>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_healthy_bottle_by_debtor<T0>(v2, arg1, arg3, v1)) {
                break
            };
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(v2, arg1, arg3)) {
                0x2::balance::join<T0>(&mut v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_recovery_mode<T0>(arg0, arg1, arg3, v1));
                continue
            };
            0x2::balance::join<T0>(&mut v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_normal_mode<T0>(arg0, arg1, arg3, v1));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

