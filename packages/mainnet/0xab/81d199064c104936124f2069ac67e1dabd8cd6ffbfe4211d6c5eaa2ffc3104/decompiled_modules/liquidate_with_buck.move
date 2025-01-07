module 0xab81d199064c104936124f2069ac67e1dabd8cd6ffbfe4211d6c5eaa2ffc3104::liquidate_with_buck {
    public fun liquidate_debtors_with_buck<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: vector<address>, arg4: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>) {
        let v0 = 0xab81d199064c104936124f2069ac67e1dabd8cd6ffbfe4211d6c5eaa2ffc3104::liquidate::liquidate_debtors<T0>(arg0, arg1, arg3, arg5);
        let (v1, v2, v3) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::tank::withdraw_all<T0>(arg0, arg1, arg5, arg2, 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::tank::deposit<T0>(arg0, arg4, arg6), arg6);
        0x2::balance::join<T0>(&mut v0, v2);
        (v1, v0, v3)
    }

    // decompiled from Move bytecode v6
}

