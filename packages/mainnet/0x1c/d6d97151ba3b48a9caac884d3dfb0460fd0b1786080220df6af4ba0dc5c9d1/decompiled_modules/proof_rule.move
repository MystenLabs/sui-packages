module 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::proof_rule {
    public fun claim<T0>(arg0: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg1: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T0, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let v1 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of_mut<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, &mut v0, 0x2::tx_context::sender(arg4));
        if (arg3 >= 0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(v1)) {
            err_index_out_of_range();
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<T0, 0x2::sui::SUI>(arg2, arg1, 0x1::vector::borrow_mut<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(v1, arg3)), arg4)
    }

    public fun create_locker<T0>(arg0: &mut 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointCap, arg2: u64, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::insert(arg0, 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::create<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(&v0, arg4), arg2, arg3);
    }

    fun err_index_out_of_range() {
        abort 0
    }

    public fun lock<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0x2::clock::Clock, arg3: 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let (v0, v1) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        let v2 = total_value<T0>(arg1, 0x2::tx_context::sender(arg4));
        let v3 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::lock<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, &mut v3, 0x2::tx_context::sender(arg4), arg3, v1, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(v2 + 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<T0, 0x2::sui::SUI>(&arg3)), v0)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg2, arg4);
    }

    public fun return_position<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let (_, v2) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, &v0, arg3))) {
            0x2::transfer::public_transfer<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::unlock<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, &mut v0, arg3, 0, v2, 0, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg2, arg4), arg3);
            v3 = v3 + 1;
        };
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::drop_assets_of<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, arg3);
    }

    public fun settle<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::has_assets<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, arg3)) {
            let v0 = total_value<T0>(arg1, arg3);
            let (v1, v2) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
            let v3 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
            0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::send_stake_point_req_with_owner<0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(&v3, arg3, v2, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(v0), v1)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg2, arg4);
        };
    }

    public fun total_value<T0>(arg0: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg1: address) : u64 {
        let v0 = 0;
        if (0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::has_assets<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1)) {
            let v1 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
            let v2 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, &v1, arg1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(v2)) {
                v0 = v0 + 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<T0, 0x2::sui::SUI>(0x1::vector::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(v2, v3));
                v3 = v3 + 1;
            };
        };
        v0
    }

    public fun unlock<T0>(arg0: &0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointConfig, arg1: &mut 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::AssetLocker<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI> {
        0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::assert_valid_config_version(arg0);
        let v0 = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::witness();
        let v1 = &mut v0;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::assets_of<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v1, v2);
        if (arg3 >= 0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(v3)) {
            err_index_out_of_range();
        };
        let v4 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<T0, 0x2::sui::SUI>(0x1::vector::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>>(v3, arg3));
        let (v5, v6) = 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::get_locker_params<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg0, arg1);
        let v7 = total_value<T0>(arg1, v2);
        0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker::unlock<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, 0x2::sui::SUI>, 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::BucketPointPhase1>(arg1, v1, v2, arg3, v6, (0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::floor(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::mul(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::float::from(v7 - v4), v5)) as u256), 0x6009b99da10a8ec5e5f108544c393191792a2970d5b710331803f31d53d4cb52::config::duration(), arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

