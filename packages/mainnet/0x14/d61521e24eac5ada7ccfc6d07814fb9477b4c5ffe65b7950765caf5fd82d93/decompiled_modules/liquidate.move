module 0x14d61521e24eac5ada7ccfc6d07814fb9477b4c5ffe65b7950765caf5fd82d93::liquidate {
    public entry fun liquidate<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &mut 0x2::tx_context::TxContext) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::update_price_from_switchboard<T0>(arg1, arg2, arg3);
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::has_liquidatable_bottle<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg2);
        assert!(v0, 0);
        let v1 = 0x2::balance::zero<T0>();
        while (v0) {
            let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
            let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v2);
            if (0x1::option::is_none<address>(&v3)) {
                break
            };
            let v4 = if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(v2, arg1, arg2)) {
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_recovery_mode<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(v3))
            } else {
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::liquidate_under_normal_mode<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(v3))
            };
            0x2::balance::join<T0>(&mut v1, v4);
            v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::has_liquidatable_bottle<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), @0x8d17d7480363059539dd21db094c50ae164c33928c517122734e2bd46951d431);
    }

    // decompiled from Move bytecode v6
}

