module 0x552f1287cae4147d8a1a4637ce99d36e5423f164f04da01829c6e36db22b09f3::bucket_liquidate {
    public fun get_liquidatable_addresses<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : vector<address> {
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
        v1
    }

    public fun liquidate_after_price_update<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = get_liquidatable_addresses<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg2);
        let v1 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<address>(&v0)) {
            let v2 = 0x1::vector::pop_back<address>(&mut v0);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg2)) {
                0x2::balance::join<T0>(&mut v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_recovery_mode<T0>(arg0, arg1, arg2, v2));
                continue
            };
            0x2::balance::join<T0>(&mut v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_normal_mode<T0>(arg0, arg1, arg2, v2));
        };
        v1
    }

    // decompiled from Move bytecode v6
}

