module 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        borrow_coin_type: 0x1::type_name::TypeName,
        xTokenSupply: u64,
        tokensInvested: u64,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    struct CheckPlease has copy, drop {
        val1: u64,
        val2: u64,
        val3: u64,
    }

    public fun user_deposit<T0, T1>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<T1>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: u8, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg22: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg23: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg24: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg25: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg26: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
        0x2::transfer::public_transfer<Receipt>(v0, 0x2::tx_context::sender(arg26));
    }

    fun get_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::get_rewards<T1>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3);
        add_rewards<T0, T1>(arg0, v0);
    }

    fun add_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = *v1 + (0x2::balance::value<T1>(&arg1) as u256) * (1000000000 as u256) / (arg0.xTokenSupply as u256);
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T1>(&arg1) as u256) * (1000000000 as u256) / (arg0.xTokenSupply as u256));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, arg1);
        };
    }

    fun assert_receipt<T0>(arg0: &Receipt, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::invalid_receipt_error());
    }

    public fun create<T0, T1>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::Admin_cap, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg5),
            name                   : arg3,
            image_url              : arg4,
            borrow_coin_type       : 0x1::type_name::get<T1>(),
            xTokenSupply           : 0,
            tokensInvested         : 0,
            rewards                : 0x2::bag::new(arg5),
            acc_rewards_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            deposit_fee            : 0,
            deposit_fee_max_cap    : arg1,
            withdrawal_fee         : 0,
            withdraw_fee_max_cap   : arg2,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    public fun deposit<T0, T1>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<T1>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: u8, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg22: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg23: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg24: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg25: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg26: &mut 0x2::tx_context::TxContext) : Receipt {
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::assert_current_version(arg0);
        assert!(0x2::coin::value<T0>(&arg10) == 0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::zero_deposit_error());
        assert!(0x1::type_name::get<T1>() == arg2.borrow_coin_type, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::borrow_coin_type_error());
        update_pool<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg8, arg9, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg17, arg22, arg23, arg24, arg25, arg26);
        get_pool_rewards_all<T0>(arg2, arg5, arg11, arg26);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<T0>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = 0x2::coin::into_balance<T0>(arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, 0x2::balance::value<T0>(&v0) * arg2.deposit_fee / 10000), arg26), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::get_fee_wallet_address(arg5));
        let v1 = exchange_rate<T0>(arg2);
        let v2 = 0x2::balance::value<T0>(&v0);
        arg2.tokensInvested = arg2.tokensInvested + v2;
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::deposit_to_navi<T0, T1>(arg3, arg11, arg12, arg13, arg14, arg16, arg17, arg18, 0x2::coin::from_balance<T0>(v0, arg26), arg19, arg20, arg7, arg8, arg9, arg26);
        let v3 = (v2 as u256) * v1 / (1000000000 as u256);
        arg2.xTokenSupply = arg2.xTokenSupply + (v3 as u64);
        let v4 = if (0x1::option::is_some<Receipt>(&arg1) == true) {
            let v5 = 0x1::option::extract<Receipt>(&mut arg1);
            let v6 = &mut v5;
            update_user_rewards_all<T0>(v6, arg2, arg11, arg26);
            v5.xTokenBalance = v5.xTokenBalance + (v3 as u64);
            v5
        } else {
            let v7 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v8 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v9 = 0;
            while (v9 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg2.acc_rewards_per_xtoken)) {
                let (v10, v11) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, v9);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v7, *v10, *v11);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v8, *v10, 0);
                v9 = v9 + 1;
            };
            Receipt{id: 0x2::object::new(arg26), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v3 as u64), last_acc_reward_per_xtoken: v7, pending_rewards: v8}
        };
        0x1::option::destroy_none<Receipt>(arg1);
        v4
    }

    public fun deposit_sui(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<0x2::sui::SUI>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg15: u8, arg16: u8, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0x2::tx_context::TxContext) : Receipt {
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::assert_current_version(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) == 0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::zero_deposit_error());
        update_pool_sui(arg2, arg3, arg4, arg5, arg6, arg10, arg7, arg8, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg15, arg20);
        get_pool_rewards_all<0x2::sui::SUI>(arg2, arg4, arg10, arg20);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<0x2::sui::SUI>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, 0x2::balance::value<0x2::sui::SUI>(&v0) * arg2.deposit_fee / 10000), arg20), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::get_fee_wallet_address(arg4));
        let v1 = exchange_rate<0x2::sui::SUI>(arg2);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        arg2.tokensInvested = arg2.tokensInvested + v2;
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::deposit_to_navi<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg3, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg20), arg17, arg18, arg6, arg7, arg8, arg20);
        let v3 = (v2 as u256) * v1 / (1000000000 as u256);
        arg2.xTokenSupply = arg2.xTokenSupply + (v3 as u64);
        let v4 = if (0x1::option::is_some<Receipt>(&arg1) == true) {
            let v5 = 0x1::option::extract<Receipt>(&mut arg1);
            let v6 = &mut v5;
            update_user_rewards_all<0x2::sui::SUI>(v6, arg2, arg10, arg20);
            v5.xTokenBalance = v5.xTokenBalance + (v3 as u64);
            v5
        } else {
            let v7 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v8 = 0;
            while (v8 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg2.acc_rewards_per_xtoken)) {
                let (v9, v10) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, v8);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v7, *v9, *v10);
                v8 = v8 + 1;
            };
            Receipt{id: 0x2::object::new(arg20), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v3 as u64), last_acc_reward_per_xtoken: v7, pending_rewards: 0x2::vec_map::empty<0x1::type_name::TypeName, u64>()}
        };
        0x1::option::destroy_none<Receipt>(arg1);
        v4
    }

    public fun destroy_receipt_and_transfer_rewards<T0>(arg0: Receipt, arg1: 0x1::option::Option<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Pool<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        get_user_rewards_all<T0>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let Receipt {
            id                         : v1,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : v6,
            pending_rewards            : _,
        } = arg0;
        let v8 = v6;
        0x2::object::delete(v1);
        let v9 = 0;
        while (v9 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v8)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v8);
            v9 = v9 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v8);
    }

    public fun exchange_rate<T0>(arg0: &mut Pool<T0>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000 as u256)
        } else {
            (arg0.xTokenSupply as u256) * (1000000000 as u256) / (arg0.tokensInvested as u256)
        }
    }

    public fun get_pool_rewards_all<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        get_rewards<T0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(arg0, arg1, arg2, arg3);
        get_rewards<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public fun get_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        get_rewards<T0, T1>(arg1, arg2, arg3, arg4);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v4 = *v2;
                *v4
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v2);
                0
            };
            let v5 = (*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000 as u256);
            let v6 = 0x1::type_name::get<T0>();
            let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v6);
            *v7 = 0;
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.rewards, v0), (v5 as u64))
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun get_user_rewards_all<T0>(arg0: &mut Receipt, arg1: 0x1::option::Option<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Pool<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_user_rewards<T0, 0x2::sui::SUI>(arg0, arg2, arg4, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg7), 0x2::tx_context::sender(arg7));
        if (arg5 == true) {
            stake_all_alpha_to_alpha_pool<T0>(arg0, arg1, arg2, arg4, arg3, arg6, arg7);
        } else {
            let v1 = get_user_rewards<T0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(arg0, arg2, arg4, arg6, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>>(0x2::coin::from_balance<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(0x2::balance::split<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(&mut v1, 0x2::balance::value<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(&v1) / 2), arg7), 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>>(0x2::coin::from_balance<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(v1, arg7), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::get_fee_wallet_address(arg4));
            if (0x1::option::is_some<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>(&arg1) == true) {
                0x2::transfer::public_transfer<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>(0x1::option::extract<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>(&mut arg1), 0x2::tx_context::sender(arg7));
            };
            0x1::option::destroy_none<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>(arg1);
        };
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Your stake object"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Made with love by AlphaFi"));
        let v4 = 0x2::package::claim<POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun set_deposit_fee<T0>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::Admin_cap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg2 <= arg1.deposit_fee_max_cap, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::fee_too_high_error());
        arg1.deposit_fee = arg2;
    }

    public fun set_withdrawal_fee<T0>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::Admin_cap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg2 <= arg1.withdraw_fee_max_cap, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::fee_too_high_error());
        arg1.withdrawal_fee = arg2;
    }

    public fun stake_all_alpha_to_alpha_pool<T0>(arg0: &mut Receipt, arg1: 0x1::option::Option<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::Pool<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_user_rewards<T0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(arg0, arg2, arg3, arg5, arg6);
        assert!(0x2::balance::value<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(&v0) > 0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::zero_deposit_error());
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alphapool::user_deposit<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(arg1, arg4, arg3, 0x2::coin::from_balance<0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(v0, arg6), arg5, arg6);
    }

    fun update_pool<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<T1>, arg2: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &0x2::clock::Clock, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg14: u8, arg15: u8, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg19: u8, arg20: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg21: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg22: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg23: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg24: &mut 0x2::tx_context::TxContext) {
        arg0.tokensInvested = 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::collect_all_rewards_and_reinvest<T0, T1>(arg1, arg2, arg3, arg6, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg5, arg7, arg8, arg18, arg4, arg19, arg20, arg21, arg22, arg23, arg24);
    }

    fun update_pool_sui(arg0: &mut Pool<0x2::sui::SUI>, arg1: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: u8, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg17: u8, arg18: &mut 0x2::tx_context::TxContext) {
        arg0.tokensInvested = 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::collect_all_rewards_and_reinvest_sui(arg1, arg2, arg5, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg4, arg6, arg7, arg16, arg3, arg17, arg18);
    }

    public fun update_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v3 = *v1;
                *v3
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v1);
                0
            };
            let v4 = 0x1::type_name::get<T0>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, &v4) == true) {
                let v5 = 0x1::type_name::get<T0>();
                let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v5);
                *v6 = *v6 + (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000 as u256)) as u64);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, 0x1::type_name::get<T0>(), (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000 as u256)) as u64));
            };
        };
    }

    public fun update_user_rewards_all<T0>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        update_user_rewards<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3);
        update_user_rewards<T0, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::alpha::ALPHA>(arg0, arg1, arg2, arg3);
    }

    public fun user_deposit_sui(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<0x2::sui::SUI>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg15: u8, arg16: u8, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        0x2::transfer::public_transfer<Receipt>(v0, 0x2::tx_context::sender(arg20));
    }

    public fun user_withdraw<T0, T1>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<T1>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: u8, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg22: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg23: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg24: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg25: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg26: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
        0x2::transfer::public_transfer<Receipt>(v0, 0x2::tx_context::sender(arg26));
    }

    public fun user_withdraw_sui(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: Receipt, arg2: &mut Pool<0x2::sui::SUI>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg15: u8, arg16: u8, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        0x2::transfer::public_transfer<Receipt>(v0, 0x2::tx_context::sender(arg20));
    }

    public fun withdraw<T0, T1>(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<T1>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: u8, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg22: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg23: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg24: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg25: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg26: &mut 0x2::tx_context::TxContext) : Receipt {
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::assert_current_version(arg0);
        assert_receipt<T0>(&arg1, arg2);
        assert!(0x1::type_name::get<T1>() == arg2.borrow_coin_type, 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::borrow_coin_type_error());
        let v0 = exchange_rate<T0>(arg2);
        assert!(arg10 <= (((arg1.xTokenBalance as u256) * (1000000000 as u256) / v0) as u64), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::insufficient_balance_error());
        update_pool<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg8, arg9, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg17, arg22, arg23, arg24, arg25, arg26);
        get_pool_rewards_all<T0>(arg2, arg5, arg11, arg26);
        let v1 = &mut arg1;
        update_user_rewards_all<T0>(v1, arg2, arg11, arg26);
        let v2 = (arg10 as u256) * v0 / (1000000000 as u256);
        arg2.xTokenSupply = arg2.xTokenSupply - (v2 as u64);
        arg1.xTokenBalance = arg1.xTokenBalance - (v2 as u64);
        let v3 = 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::withdraw_from_navi<T0, T1>(arg3, arg11, arg12, arg13, arg14, arg16, arg17, arg18, arg10, arg19, arg20, arg7, arg8, arg9, arg26);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) * arg2.withdrawal_fee / 10000), arg26), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::get_fee_wallet_address(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg26), 0x2::tx_context::sender(arg26));
        let v4 = CheckPlease{
            val1 : arg2.tokensInvested,
            val2 : arg10,
            val3 : (v0 as u64),
        };
        0x2::event::emit<CheckPlease>(v4);
        let v5 = if (arg10 > arg2.tokensInvested) {
            0
        } else {
            arg2.tokensInvested - arg10
        };
        arg2.tokensInvested = v5;
        arg1
    }

    public fun withdraw_sui(arg0: &0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::Version, arg1: Receipt, arg2: &mut Pool<0x2::sui::SUI>, arg3: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::Distributor, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg15: u8, arg16: u8, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0x2::tx_context::TxContext) : Receipt {
        0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::version::assert_current_version(arg0);
        assert_receipt<0x2::sui::SUI>(&arg1, arg2);
        let v0 = exchange_rate<0x2::sui::SUI>(arg2);
        assert!(arg9 <= (((arg1.xTokenBalance as u256) * (1000000000 as u256) / v0) as u64), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::error::insufficient_balance_error());
        update_pool_sui(arg2, arg3, arg4, arg5, arg6, arg10, arg7, arg8, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg15, arg20);
        get_pool_rewards_all<0x2::sui::SUI>(arg2, arg4, arg10, arg20);
        let v1 = &mut arg1;
        update_user_rewards_all<0x2::sui::SUI>(v1, arg2, arg10, arg20);
        let v2 = (arg9 as u256) * v0 / (1000000000 as u256);
        arg2.xTokenSupply = arg2.xTokenSupply - (v2 as u64);
        arg1.xTokenBalance = arg1.xTokenBalance - (v2 as u64);
        let v3 = 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::investor::withdraw_from_navi<0x2::sui::SUI, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg3, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg9, arg17, arg18, arg6, arg7, arg8, arg20);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, 0x2::balance::value<0x2::sui::SUI>(&v3) * arg2.withdrawal_fee / 10000), arg20), 0x13191fc4caec04c691d11107700be2fffbcb9fa0f4e70f37af7512f9463e7924::distributor::get_fee_wallet_address(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg20), 0x2::tx_context::sender(arg20));
        let v4 = CheckPlease{
            val1 : arg2.tokensInvested,
            val2 : arg9,
            val3 : (v0 as u64),
        };
        0x2::event::emit<CheckPlease>(v4);
        let v5 = if (arg9 > arg2.tokensInvested) {
            0
        } else {
            arg2.tokensInvested - arg9
        };
        arg2.tokensInvested = v5;
        arg1
    }

    // decompiled from Move bytecode v6
}

