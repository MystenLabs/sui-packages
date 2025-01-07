module 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::lst_proof_rule {
    public fun claim<T0>(arg0: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg1: &mut 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::Fountain<T0, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let v1 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of_mut<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, &mut v0, 0x2::tx_context::sender(arg4));
        if (arg3 >= 0x1::vector::length<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(v1)) {
            err_index_out_of_range();
        };
        0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::claim<T0, 0x2::sui::SUI>(arg1, arg2, 0x1::vector::borrow_mut<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(v1, arg3), arg4)
    }

    fun get_raw_debt<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>) : u64 {
        if (0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::bottle_exists<T0>(arg0, 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::strap_address<T0, 0x2::sui::SUI>(arg1))) {
            0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::get_raw_debt<T0>(arg0, 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::strap_address<T0, 0x2::sui::SUI>(arg1))
        } else {
            0
        }
    }

    fun borrow_asset<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1, arg1: &0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: address, arg3: u64) : &0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI> {
        let v0 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, arg0, arg2);
        if (arg3 >= 0x1::vector::length<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(v0)) {
            err_index_out_of_range();
        };
        0x1::vector::borrow<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(v0, arg3)
    }

    public fun create_locker<T0>(arg0: &mut 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointCap, arg2: u64, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::insert(arg0, 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::create<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(&v0, arg4), arg2, arg3);
    }

    fun err_index_out_of_range() {
        abort 0
    }

    public fun liquidate<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::Fountain<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v1, arg5))) {
            let (v3, _, v5) = 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::liquidate_with_info<T0, 0x2::sui::SUI>(arg3, arg2, arg4, 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::strap_address<T0, 0x2::sui::SUI>(0x1::vector::borrow<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v1, arg5), v2)), arg6);
            if (v3) {
                0x2::transfer::public_transfer<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(unlock_internal<T0>(arg0, arg1, arg2, arg4, v2, arg5, v5, arg6), arg5);
            };
            v2 = v2 + 1;
        };
    }

    public fun lock<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        let v3 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::lock<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, &mut v3, v0, arg4, v2, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(owner_value<T0>(arg1, arg2, v0) + get_raw_debt<T0>(arg2, &arg4)), v1)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg3, arg5);
    }

    public fun owner_value<T0>(arg0: &0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: address) : u64 {
        let v0 = 0;
        if (0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::has_assets<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg2)) {
            let v1 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
            let v2 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, &v1, arg2);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(v2)) {
                v0 = v0 + get_raw_debt<T0>(arg1, 0x1::vector::borrow<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(v2, v3));
                v3 = v3 + 1;
            };
        };
        v0
    }

    public fun unlock<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::Fountain<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI> {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::strap_address<T0, 0x2::sui::SUI>(borrow_asset<T0>(&v0, arg1, v1, arg5));
        let v3 = if (0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::bottle_exists<T0>(arg2, v2)) {
            0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::get_raw_debt<T0>(arg2, v2)
        } else {
            let (_, _, v6) = 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::liquidate_with_info<T0, 0x2::sui::SUI>(arg3, arg2, arg4, v2, arg6);
            v6
        };
        unlock_internal<T0>(arg0, arg1, arg2, arg4, arg5, v1, v3, arg6)
    }

    fun unlock_internal<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI> {
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let v1 = &mut v0;
        if (arg4 >= 0x1::vector::length<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>>(0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v1, arg5))) {
            err_index_out_of_range();
        };
        let (v2, v3) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::unlock<0x5d019c033bb8051fe9631cf910d0f4d077364d64ed4bb1940e98e6dc419a8d59::fountain::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v1, arg5, arg4, v3, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(owner_value<T0>(arg1, arg2, arg5) - arg6), v2)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg3, arg7)
    }

    // decompiled from Move bytecode v6
}

