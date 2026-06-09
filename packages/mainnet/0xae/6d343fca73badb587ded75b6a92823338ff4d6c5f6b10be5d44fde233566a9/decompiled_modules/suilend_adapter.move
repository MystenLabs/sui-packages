module 0xae6d343fca73badb587ded75b6a92823338ff4d6c5f6b10be5d44fde233566a9::suilend_adapter {
    struct RewardBufferKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct SuilendWitness<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct SuilendAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        reserve_array_index: u64,
        reward_index_table: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        reward_pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        mid_pool: 0x2::object::ID,
        min_reward_redeem: u64,
        apr: u256,
        apr_ratio: u256,
        apr_sync_ms: u64,
        reward_flow: u64,
        reward_apr: u256,
        reward_sync_ms: u64,
    }

    struct RewardHarvest<phantom T0, phantom T1> {
        earnings: 0x2::balance::Balance<T1>,
        available: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        depth: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
    }

    public fun new<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: vector<u64>, arg5: vector<0x2::object::ID>, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::AdminWitness<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam::SAM>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg7);
        let v1 = 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg7);
        0x1::vector::reverse<u64>(&mut arg4);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg3) == 0x1::vector::length<u64>(&arg4), 13906834556595470335);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg3)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v0, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg3);
        0x1::vector::destroy_empty<u64>(arg4);
        0x1::vector::reverse<0x2::object::ID>(&mut arg5);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg3) == 0x1::vector::length<0x2::object::ID>(&arg5), 13906834569480372223);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg3);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&arg3)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v1, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg3), 0x1::vector::pop_back<0x2::object::ID>(&mut arg5));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg3);
        0x1::vector::destroy_empty<0x2::object::ID>(arg5);
        let v4 = SuilendAdapter<T0, T1, T2>{
            id                   : 0x2::object::new(arg7),
            coin_in              : 0,
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg7),
            reserve_array_index  : arg1,
            reward_index_table   : v0,
            reward_pool_table    : v1,
            mid_pool             : arg2,
            min_reward_redeem    : 1000000,
            apr                  : 0,
            apr_ratio            : 0,
            apr_sync_ms          : 0,
            reward_flow          : 0,
            reward_apr           : 0,
            reward_sync_ms       : 0,
        };
        0x2::transfer::public_share_object<SuilendAdapter<T0, T1, T2>>(v4);
    }

    public fun allocate_to_protocol<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>, arg4: &0x2::clock::Clock, arg5: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendWitness<T0, T2>{dummy_field: false};
        let v1 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::allocate_to_protocol<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v0, arg5, arg6);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T1>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v1, arg6), arg6), arg6);
    }

    public fun begin_approve<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, T1> {
        learn_apr_from_ratio<T0, T1, T2>(arg0, arg2, arg3);
        let v0 = redeem_growth<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        snapshot<T0, T1, T2>(arg0, arg1, arg2, v0)
    }

    public fun begin_approve_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, 0x2::sui::SUI> {
        let v0 = redeem_growth_sui<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
        snapshot<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg2, v0)
    }

    fun buffer_join_take<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        let v1 = if (0x2::dynamic_field::exists<RewardBufferKey>(arg0, v0)) {
            0x2::dynamic_field::remove<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0)
        } else {
            0x2::balance::zero<T0>()
        };
        let v2 = v1;
        0x2::balance::join<T0>(&mut v2, arg1);
        v2
    }

    fun buffer_put<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::add<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
    }

    fun claim_rewards<T0, T1, T2, T3>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap))) == 0) {
            return 0x2::balance::zero<T3>()
        };
        let v0 = 0x2::balance::zero<T3>();
        let v1 = claimable_reward_indices<T0, T1, T2, T3>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            0x2::balance::join<T3>(&mut v0, 0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T3>(arg1, &arg0.obligation_owner_cap, arg2, arg0.reserve_array_index, 0x1::vector::pop_back<u64>(&mut v1), true, arg3)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        v0
    }

    fun claimable_reward_indices<T0, T1, T2, T3>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64) : vector<u64> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1));
        let v1 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolRewardManager>(v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(v0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v4 = false;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v3)) {
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_reward_manager_id(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v3, v6)) == v1) {
                v4 = true;
                v5 = v6;
                break
            };
            v6 = v6 + 1;
        };
        if (!v4) {
            return vector[]
        };
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v3, v5));
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v2)) {
            let v10 = 0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v2, v9);
            if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(v10)) {
                let v11 = 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(v10);
                if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::coin_type(v11) == 0x1::type_name::with_defining_ids<T3>()) {
                    let v12 = v9 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v7) && 0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v7, v9));
                    if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::end_time_ms(v11) >= arg2 || v12) {
                        0x1::vector::push_back<u64>(&mut v8, v9);
                    };
                };
            };
            v9 = v9 + 1;
        };
        v8
    }

    public fun end_approve<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg2: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRequest<T1>, arg3: RewardHarvest<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let RewardHarvest {
            earnings  : v0,
            available : v1,
            apr       : v2,
            depth     : v3,
        } = arg3;
        let (v4, v5, v6) = 0xa4aa4e069af28c4b7a3842a23d5235125f29af0ca87463a4bb28acaff89dfb0f::apr::accrue_reward(arg0.reward_apr, arg0.reward_flow, arg0.coin_in, arg0.reward_sync_ms, 0x2::clock::timestamp_ms(arg4));
        arg0.reward_apr = v4;
        arg0.reward_flow = v5;
        arg0.reward_sync_ms = v6;
        let v7 = SuilendWitness<T0, T2>{dummy_field: false};
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::approve_protocol_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg2, v1, v3, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v2, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(v4)), v0, v7, arg5, arg6);
    }

    fun get_apr<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(arg0.apr)
    }

    fun get_available_liquidity<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u8) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1));
        let v1 = if (v0 < arg0.coin_in) {
            v0
        } else {
            arg0.coin_in
        };
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v1, arg2)
    }

    public fun harvest_reward<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut RewardHarvest<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_rewards_route<T0, T1, T2, T3, T4>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        arg0.reward_flow = arg0.reward_flow + 0x2::balance::value<T1>(&v0);
        0x2::balance::join<T1>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_lst<T0, T1, T2, T3: drop>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut RewardHarvest<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_rewards_route<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        arg0.reward_flow = arg0.reward_flow + 0x2::balance::value<T1>(&v0);
        0x2::balance::join<T1>(&mut arg1.earnings, v0);
    }

    public fun inject_reward<T0, T1, T2, T3>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: 0x2::coin::Coin<T3>, arg2: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::AdminWitness<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam::SAM>) {
        let v0 = &mut arg0.id;
        let v1 = buffer_join_take<T3>(v0, 0x2::coin::into_balance<T3>(arg1));
        let v2 = &mut arg0.id;
        buffer_put<T3>(v2, v1);
    }

    fun learn_apr_from_ratio<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0xa4aa4e069af28c4b7a3842a23d5235125f29af0ca87463a4bb28acaff89dfb0f::apr::update_apr_from_ratio(arg0.apr, arg0.apr_ratio, arg0.apr_sync_ms, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))), 0x2::clock::timestamp_ms(arg2));
        arg0.apr = v0;
        arg0.apr_ratio = v1;
        arg0.apr_sync_ms = v2;
    }

    public fun min_reward_redeem<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>) : u64 {
        arg0.min_reward_redeem
    }

    fun redeem_growth<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0)));
        if (v1 <= arg0.coin_in) {
            return 0x2::balance::zero<T1>()
        };
        let v2 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::u64::mul_div_down(v1 - arg0.coin_in, v0, v1);
        if (v2 == 0) {
            return 0x2::balance::zero<T1>()
        };
        withdraw_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4)
    }

    fun redeem_growth_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, 0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap))))));
        let (v2, v3, v4) = 0xa4aa4e069af28c4b7a3842a23d5235125f29af0ca87463a4bb28acaff89dfb0f::apr::update_apr_from_ratio(arg0.apr, arg0.apr_ratio, arg0.apr_sync_ms, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v0), 0x2::clock::timestamp_ms(arg2));
        arg0.apr = v2;
        arg0.apr_ratio = v3;
        arg0.apr_sync_ms = v4;
        if (v1 <= arg0.coin_in) {
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        withdraw_staked_sui_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1 - arg0.coin_in, arg5)
    }

    fun redeem_rewards_route<T0, T1, T2, T3: drop>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>>(arg5) == arg0.mid_pool, 0);
        let v0 = claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg6, arg7);
        let v1 = &mut arg0.id;
        let v2 = buffer_join_take<T3>(v1, v0);
        if (0x2::balance::value<T3>(&v2) < arg0.min_reward_redeem) {
            let v3 = &mut arg0.id;
            buffer_put<T3>(v3, v2);
            return 0x2::balance::zero<T1>()
        };
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg3, 0x2::coin::from_balance<T3>(v2, arg7), arg4, arg7));
        let v5 = &mut v4;
        let v6 = &mut arg0.id;
        let v7 = buffer_join_take<0x2::sui::SUI>(v6, v4);
        let v8 = &mut arg0.id;
        buffer_put<0x2::sui::SUI>(v8, v7);
        swap_b_to_a<T1, 0x2::sui::SUI>(arg2, arg5, v5, arg6)
    }

    fun restake_excess<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg3) <= arg4) {
            return arg3
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3) - arg4;
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1)))) == 0) {
            let v1 = &mut arg0.id;
            buffer_put<0x2::sui::SUI>(v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0));
            return arg3
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0), arg5), arg5), arg5);
        arg3
    }

    public fun set_mid_pool<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: 0x2::object::ID, arg2: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::AdminWitness<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam::SAM>) {
        arg0.mid_pool = arg1;
    }

    public fun set_min_reward_redeem<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: u64, arg2: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::AdminWitness<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam::SAM>) {
        arg0.min_reward_redeem = arg1;
    }

    public fun set_reward_index_table<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: vector<0x1::type_name::TypeName>, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::AdminWitness<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam::SAM>) {
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1);
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.reward_index_table, v1);
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg1);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834732689129471);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.reward_index_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::reverse<0x2::object::ID>(&mut arg4);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<0x2::object::ID>(&arg4), 13906834745574031359);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<0x2::object::ID>(&mut arg4));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<0x2::object::ID>(arg4);
    }

    fun snapshot<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x2::balance::Balance<T1>) : RewardHarvest<T0, T1> {
        let v0 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::decimals<T1, T2>(arg1);
        RewardHarvest<T0, T1>{
            earnings  : arg3,
            available : get_available_liquidity<T0, T1, T2>(arg0, arg2, v0),
            apr       : get_apr<T0, T1, T2>(arg0),
            depth     : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg2)), v0),
        }
    }

    fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::join<T0>(arg2, v0);
        v1
    }

    fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::join<T1>(arg2, v1);
        v0
    }

    fun swap_rewards_route<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg3) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T3>()), 0);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>>(arg4) == arg0.mid_pool, 0);
        let v0 = arg0.min_reward_redeem;
        let v1 = &mut arg0.id;
        let v2 = buffer_join_take<T3>(v1, claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg5, arg6));
        if (0x2::balance::value<T3>(&v2) < v0) {
            let v3 = &mut arg0.id;
            buffer_put<T3>(v3, v2);
            return 0x2::balance::zero<T1>()
        };
        let v4 = &mut v2;
        let v5 = &mut arg0.id;
        buffer_put<T3>(v5, v2);
        let v6 = &mut arg0.id;
        let v7 = buffer_join_take<T4>(v6, swap_a_to_b<T3, T4>(arg2, arg3, v4, arg5));
        if (0x2::balance::value<T4>(&v7) < v0) {
            let v8 = &mut arg0.id;
            buffer_put<T4>(v8, v7);
            return 0x2::balance::zero<T1>()
        };
        let v9 = &mut v7;
        let v10 = &mut arg0.id;
        buffer_put<T4>(v10, v7);
        swap_b_to_a<T1, T4>(arg2, arg4, v9, arg5)
    }

    public fun update_apr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: u256, arg2: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::AdminWitness<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam::SAM>) {
        arg0.apr = arg1;
    }

    fun withdraw_inner<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, arg4, arg5), arg3, arg5))
    }

    public fun withdraw_rbr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::amount<T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_sui_amount<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::fill_rebalance_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_rbr_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::amount<0x2::sui::SUI>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_staked_sui_amount<T0, T1>(arg0, arg2, arg4, arg5, arg6, v0, arg8);
        let v2 = restake_excess<T0, T1>(arg0, arg2, arg4, v1, v0, arg8);
        let v3 = SuilendWitness<T0, T1>{dummy_field: false};
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::fill_rebalance_request<0x2::sui::SUI, T1, SuilendWitness<T0, T1>>(arg1, arg3, v2, v3, arg7, arg8);
    }

    fun withdraw_staked_sui_amount<T0, T1>(arg0: &SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1))));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, 0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        if (v2 == 0) {
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, v2, arg6), arg3, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg0.reserve_array_index, &v3, arg4, arg6);
        0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, v3, arg6))
    }

    fun withdraw_sui_amount<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        withdraw_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg5)
    }

    public fun withdraw_wdr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::get_coin_amount<T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_sui_amount<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::fill_withdraw_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_wdr_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::get_coin_amount<0x2::sui::SUI>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_staked_sui_amount<T0, T1>(arg0, arg2, arg4, arg5, arg6, v0, arg8);
        let v2 = restake_excess<T0, T1>(arg0, arg2, arg4, v1, v0, arg8);
        let v3 = SuilendWitness<T0, T1>{dummy_field: false};
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::fill_withdraw_request<0x2::sui::SUI, T1, SuilendWitness<T0, T1>>(arg1, arg3, v2, v3, arg7, arg8);
    }

    public fun witness_type<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<SuilendWitness<T0, T1>>()
    }

    // decompiled from Move bytecode v7
}

