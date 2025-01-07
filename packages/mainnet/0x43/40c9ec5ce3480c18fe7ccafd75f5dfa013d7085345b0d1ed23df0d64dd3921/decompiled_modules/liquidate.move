module 0x4340c9ec5ce3480c18fe7ccafd75f5dfa013d7085345b0d1ed23df0d64dd3921::liquidate {
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

    public fun get_liquidable_debtors<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : (u64, vector<address>) {
        let v0 = 0;
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(arg0);
        let v2 = 0x1::vector::empty<address>();
        while (0x1::option::is_some<address>(&v1)) {
            let v3 = 0x1::option::destroy_some<address>(v1);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_healthy_bottle_by_debtor<T0>(arg0, arg1, arg2, v3)) {
                break
            };
            let (_, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(arg0, v3, arg2);
            v0 = v0 + v5;
            0x1::vector::push_back<address>(&mut v2, v3);
            v1 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(arg0, v3);
        };
        (v0, v2)
    }

    public fun liquidate_after_price_update<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (_, v1) = get_liquidable_debtors<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg2);
        liquidate_debtors<T0>(arg0, arg1, v1, arg2)
    }

    public fun liquidate_debtors<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: vector<address>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg3)) {
                0x2::balance::join<T0>(&mut v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_recovery_mode<T0>(arg0, arg1, arg3, v1));
                continue
            };
            0x2::balance::join<T0>(&mut v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_normal_mode<T0>(arg0, arg1, arg3, v1));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

