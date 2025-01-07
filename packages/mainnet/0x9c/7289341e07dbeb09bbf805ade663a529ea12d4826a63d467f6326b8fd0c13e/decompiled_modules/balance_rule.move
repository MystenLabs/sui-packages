module 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::balance_rule {
    public fun create_locker<T0>(arg0: &mut 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointCap, arg2: u64, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::insert(arg0, 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::balance_locker::create<T0, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(&v0, arg4), arg2, arg3);
    }

    public fun deposit<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x2::balance::Balance<T0>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let (v0, v1) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x2::balance::Balance<T0>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        let v2 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::balance_locker::lock<T0, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, &mut v2, 0x2::tx_context::sender(arg4), arg3, v1, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::balance_locker::owner_locked_balance<T0, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, 0x2::tx_context::sender(arg4)) + 0x2::balance::value<T0>(&arg3)), v0)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg2, arg4);
    }

    fun err_insufficient_to_withdraw() {
        abort 101
    }

    public fun withdraw<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x2::balance::Balance<T0>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::balance_locker::owner_locked_balance<T0, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v0);
        if (arg3 > v1) {
            err_insufficient_to_withdraw();
        };
        let (v2, v3) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x2::balance::Balance<T0>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        let v4 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::balance_locker::unlock<T0, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, &mut v4, v0, arg3, v3, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(v1 - arg3), v2)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

