module 0x8b39e53e8ea673b87f8491cd7caee3d4c53c8f34f8d7838948be7055a39f3654::tank {
    public fun deposit<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0> {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank_mut<T0>(arg0), arg1, arg2)
    }

    public fun merge_withdraw_all<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: vector<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>) {
        let v0 = 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>();
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>();
        while (!0x1::vector::is_empty<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(&arg4)) {
            let (v3, v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::tank_withdraw<T0>(arg0, arg1, arg2, arg3, 0x1::vector::pop_back<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(&mut arg4), arg5);
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v0, v3);
            0x2::balance::join<T0>(&mut v1, v4);
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut v2, v5);
        };
        0x1::vector::destroy_empty<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>>(arg4);
        (v0, v1, v2)
    }

    public fun withdraw_all<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::tank_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

