module 0xf28ffed06bc7d07fca5d6044dd089ba8db46b0d97f506fe98c008cabc864fad5::suilend_adapter {
    struct SuilendWitness<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct SuilendAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        reserve_array_index: u64,
        reward_pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        mid_pool: 0x2::object::ID,
        min_reward_redeem: u64,
        apr: 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::AprState,
        reward: 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::RewardAprState,
    }

    struct RewardHarvest<phantom T0, phantom T1, phantom T2> {
        earnings: 0x2::balance::Balance<T1>,
        available: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        depth: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
    }

    public fun new<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapter<T0, T1, T2>{
            id                   : 0x2::object::new(arg4),
            coin_in              : 0,
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg4),
            reserve_array_index  : arg1,
            reward_pool_table    : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg4),
            mid_pool             : arg2,
            min_reward_redeem    : 1000000,
            apr                  : 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::new(),
            reward               : 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::new(),
        };
        0x2::transfer::public_share_object<SuilendAdapter<T0, T1, T2>>(v0);
    }

    public fun allocate_to_protocol<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::RebalanceRequest<T1, T2>, arg4: &0x2::clock::Clock, arg5: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendWitness<T0, T2>{dummy_field: false};
        let v1 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::allocate_to_protocol<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v0, arg5, arg6);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T1>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v1, arg6), arg6), arg6);
    }

    fun assert_reward_pool<T0, T1, T2, T3>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: 0x2::object::ID) {
        assert!(arg1 == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T3>()), 0);
    }

    public fun begin_approve<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, T1, T2> {
        let v0 = redeem_growth<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        snapshot<T0, T1, T2>(arg0, arg1, arg2, v0)
    }

    public fun begin_approve_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, 0x2::sui::SUI, T1> {
        let v0 = redeem_growth_sui<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
        snapshot<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg2, v0)
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

    public fun drop_reward_pool<T0, T1, T2, T3>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T3>());
    }

    public fun end_approve<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T1, T2>, arg2: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::ptr::ProtocolRequest<T1>, arg3: RewardHarvest<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let RewardHarvest {
            earnings  : v0,
            available : v1,
            apr       : v2,
            depth     : v3,
        } = arg3;
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::accrue(&mut arg0.reward, arg0.coin_in, 0x2::clock::timestamp_ms(arg4));
        let v4 = SuilendWitness<T0, T2>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::approve_protocol_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg2, v1, v3, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v2, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::value(&arg0.reward))), v0, v4, arg5, arg6);
    }

    public fun harvest_reward<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut RewardHarvest<T0, T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_rewards_route<T0, T1, T2, T3, T4>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<T1>(&v0));
        0x2::balance::join<T1>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_direct<T0, T1, T2, T3>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut RewardHarvest<T0, T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_reward_pool<T0, T1, T2, T3>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>>(arg4));
        let v0 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_b_to_a<T1, T3>(&mut arg0.id, claim_rewards<T0, T1, T2, T3>(arg0, arg2, arg5, arg6), arg0.min_reward_redeem, arg3, arg4, arg5);
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<T1>(&v0));
        0x2::balance::join<T1>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_lst<T0, T1, T2, T3: drop>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut RewardHarvest<T0, T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_rewards_route<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<T1>(&v0));
        0x2::balance::join<T1>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_lst_native<T0, T1, T2: drop>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut RewardHarvest<T0, 0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rewards<T0, 0x2::sui::SUI, T1, T2>(arg0, arg2, arg5, arg6);
        if (0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T2>(&mut arg0.id, v0) < arg0.min_reward_redeem) {
            return
        };
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg3, 0x2::coin::from_balance<T2>(0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::take<T2>(&mut arg0.id), arg6), arg4, arg6));
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<0x2::sui::SUI>(&v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.earnings, v1);
    }

    public fun inject_reward<T0, T1, T2, T3>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: 0x2::coin::Coin<T3>, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T3>(&mut arg0.id, 0x2::coin::into_balance<T3>(arg1));
    }

    fun learn_and_growth<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1));
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0)));
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::observe_ratio(&mut arg0.apr, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v1), 0x2::clock::timestamp_ms(arg2));
        let v3 = if (v2 <= arg0.coin_in) {
            0
        } else {
            v2 - arg0.coin_in
        };
        (v3, v0, v2)
    }

    public fun min_reward_redeem<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>) : u64 {
        arg0.min_reward_redeem
    }

    fun redeem_ctokens<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, arg4, arg5), arg3, arg5))
    }

    fun redeem_growth<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = learn_and_growth<T0, T1, T2>(arg0, arg1, arg2);
        if (v0 == 0) {
            return 0x2::balance::zero<T1>()
        };
        let v3 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::u64::mul_div_down(v0, v1, v2);
        if (v3 == 0) {
            return 0x2::balance::zero<T1>()
        };
        redeem_ctokens<T0, T1, T2>(arg0, arg1, arg2, arg3, v3, arg4)
    }

    fun redeem_growth_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (v0, _, _) = learn_and_growth<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg2);
        let v3 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::take<0x2::sui::SUI>(&mut arg0.id);
        if (v0 == 0) {
            return v3
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v3, unstake_underlying<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5));
        v3
    }

    fun redeem_rewards_route<T0, T1, T2, T3: drop>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>>(arg5) == arg0.mid_pool, 0);
        let v0 = claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg6, arg7);
        if (0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T3>(&mut arg0.id, v0) < arg0.min_reward_redeem) {
            return 0x2::balance::zero<T1>()
        };
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_b_to_a<T1, 0x2::sui::SUI>(&mut arg0.id, 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg3, 0x2::coin::from_balance<T3>(0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::take<T3>(&mut arg0.id), arg7), arg4, arg7)), 0, arg2, arg5, arg6)
    }

    fun redeem_underlying<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        if (v2 == 0) {
            return 0x2::balance::zero<T1>()
        };
        redeem_ctokens<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg5)
    }

    fun restake_excess<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg3) <= arg4) {
            return arg3
        };
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3) - arg4;
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1)))) == 0) {
            0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<0x2::sui::SUI>(&mut arg0.id, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0));
            return arg3
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0), arg5), arg5), arg5);
        arg3
    }

    public fun set_mid_pool<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: 0x2::object::ID, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        arg0.mid_pool = arg1;
    }

    public fun set_min_reward_redeem<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: u64, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        assert!(arg1 > 0, 1);
        arg0.min_reward_redeem = arg1;
    }

    public fun set_reward_pool<T0, T1, T2, T3>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: 0x2::object::ID, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::table_util::upsert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T3>(), arg1);
    }

    fun snapshot<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x2::balance::Balance<T1>) : RewardHarvest<T0, T1, T2> {
        let v0 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::decimals<T1, T2>(arg1);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg2));
        let v2 = if (v1 < arg0.coin_in) {
            v1
        } else {
            arg0.coin_in
        };
        RewardHarvest<T0, T1, T2>{
            earnings  : arg3,
            available : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v2, v0),
            apr       : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::value(&arg0.apr)),
            depth     : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v1, v0),
        }
    }

    fun swap_rewards_route<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_reward_pool<T0, T1, T2, T3>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg3));
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>>(arg4) == arg0.mid_pool, 0);
        let v0 = arg0.min_reward_redeem;
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_b_to_a<T1, T4>(&mut arg0.id, 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_a_to_b<T3, T4>(&mut arg0.id, claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg5, arg6), v0, arg2, arg3, arg5), v0, arg2, arg4, arg5)
    }

    fun unstake_underlying<T0, T1>(arg0: &SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
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

    public fun update_apr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: u256, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::set(&mut arg0.apr, arg1);
    }

    public fun withdraw_rbr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::RebalanceRequest<T1, T2>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::amount<T1, T2>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = redeem_underlying<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_rebalance_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_rbr_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::RebalanceRequest<0x2::sui::SUI, T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::amount<0x2::sui::SUI, T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = unstake_underlying<T0, T1>(arg0, arg2, arg4, arg5, arg6, v0, arg8);
        let v2 = restake_excess<T0, T1>(arg0, arg2, arg4, v1, v0, arg8);
        let v3 = SuilendWitness<T0, T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_rebalance_request<0x2::sui::SUI, T1, SuilendWitness<T0, T1>>(arg1, arg3, v2, v3, arg7, arg8);
    }

    public fun withdraw_wdr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::WithdrawRequest<T1, T2>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::get_coin_amount<T1, T2>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = redeem_underlying<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_withdraw_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_wdr_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::WithdrawRequest<0x2::sui::SUI, T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::get_coin_amount<0x2::sui::SUI, T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = unstake_underlying<T0, T1>(arg0, arg2, arg4, arg5, arg6, v0, arg8);
        let v2 = restake_excess<T0, T1>(arg0, arg2, arg4, v1, v0, arg8);
        let v3 = SuilendWitness<T0, T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_withdraw_request<0x2::sui::SUI, T1, SuilendWitness<T0, T1>>(arg1, arg3, v2, v3, arg7, arg8);
    }

    public fun witness_type<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<SuilendWitness<T0, T1>>()
    }

    // decompiled from Move bytecode v7
}

