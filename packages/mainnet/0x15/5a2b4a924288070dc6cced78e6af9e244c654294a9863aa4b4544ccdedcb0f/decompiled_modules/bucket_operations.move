module 0x155a2b4a924288070dc6cced78e6af9e244c654294a9863aa4b4544ccdedcb0f::bucket_operations {
    public entry fun borrow<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0x155a2b4a924288070dc6cced78e6af9e244c654294a9863aa4b4544ccdedcb0f::utils::transfer_non_zero_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), arg4, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun purely_repay<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x155a2b4a924288070dc6cced78e6af9e244c654294a9863aa4b4544ccdedcb0f::utils::transfer_non_zero_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay<T0>(arg0, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1), arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun redeem<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        0x155a2b4a924288070dc6cced78e6af9e244c654294a9863aa4b4544ccdedcb0f::utils::transfer_non_zero_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::redeem<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3), arg4), 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun repay<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3);
        let v2 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v1);
        let (v3, v4) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_by_debtor<T0>(arg0, v0);
        assert!(v3 >= arg4, 0);
        assert!(v4 >= v2, 0);
        let v5 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v4, arg4, v3);
        let v6 = if (v5 > v2) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow<T0>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), v5 - v2, arg5, arg6));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay<T0>(arg0, v1, arg6)
        } else if (v5 < v2) {
            let v7 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay<T0>(arg0, v1, arg6);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up<T0>(arg0, v7, v0, arg5);
            0x2::balance::split<T0>(&mut v7, arg4)
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay<T0>(arg0, v1, arg6)
        };
        0x155a2b4a924288070dc6cced78e6af9e244c654294a9863aa4b4544ccdedcb0f::utils::transfer_non_zero_balance<T0>(v6, v0, arg6);
    }

    public entry fun top_up<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: 0x1::option::Option<address>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

