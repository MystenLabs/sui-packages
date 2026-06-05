module 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter {
    struct RewardBufferKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct MinRewardRedeemKey has copy, drop, store {
        dummy_field: bool,
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
        apr: u256,
    }

    public fun new<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg5);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834449221287935);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v0, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        let v2 = SuilendAdapter<T0, T1, T2>{
            id                   : 0x2::object::new(arg5),
            coin_in              : 0,
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg5),
            reserve_array_index  : arg1,
            reward_index_table   : v0,
            apr                  : 0,
        };
        0x2::transfer::public_share_object<SuilendAdapter<T0, T1, T2>>(v2);
    }

    public fun allocate_to_protocol<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>, arg4: &0x2::clock::Clock, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendWitness<T0, T2>{dummy_field: false};
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::allocate_to_protocol<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v0, arg5, arg6);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T1>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v1, arg6), arg6), arg6);
    }

    fun approve_and_record<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg4: 0x2::balance::Balance<T1>, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::decimals<T1, T2>(arg1);
        let v1 = get_apr<T0, T1, T2>(arg0);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::approve_protocol_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, get_available_liquidity<T0, T1, T2>(arg0, arg2, v0), v1, arg4, v2, arg5, arg6);
        let v3 = SuilendWitness<T0, T2>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::record_point<T1, T2, SuilendWitness<T0, T2>>(arg1, v1, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg2)), v0), v3, arg5);
    }

    public fun approve_protocol_request_point<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        learn_apr_from_ratio<T0, T1, T2>(arg0, arg2, arg4);
        let v0 = redeem_growth<T0, T1, T2>(arg0, arg2, arg4, arg5, arg7);
        approve_and_record<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg6, arg7);
    }

    public fun approve_protocol_request_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_growth_sui<T0, T1>(arg0, arg2, arg4, arg5, arg6, arg8);
        approve_and_record<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg2, arg3, v0, arg7, arg8);
    }

    public fun approve_protocol_request_usdc<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg7: &0x2::clock::Clock, arg8: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        learn_apr_from_ratio<T0, T1, T2>(arg0, arg2, arg7);
        let v0 = swap_rewards_route<T0, T1, T2, T3, T4>(arg0, arg2, arg4, arg5, arg6, arg7, arg10);
        let v1 = redeem_growth<T0, T1, T2>(arg0, arg2, arg7, arg8, arg10);
        0x2::balance::join<T1>(&mut v0, v1);
        approve_and_record<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg9, arg10);
    }

    public fun approve_protocol_request_usdc_lst<T0, T1, T2, T3: drop>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg10: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        learn_apr_from_ratio<T0, T1, T2>(arg0, arg2, arg8);
        let v0 = redeem_rewards_route<T0, T1, T2, T3>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, arg11);
        let v1 = redeem_growth<T0, T1, T2>(arg0, arg2, arg8, arg9, arg11);
        0x2::balance::join<T1>(&mut v0, v1);
        approve_and_record<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg10, arg11);
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
        0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T3>(arg1, &arg0.obligation_owner_cap, arg2, arg0.reserve_array_index, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_index_table, 0x1::type_name::with_defining_ids<T3>()), true, arg3))
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

    fun learn_apr_from_ratio<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        arg0.apr = 0xb23208de702112f80bc9a36b441c9d5df3be072e7e7157be09d8818cefb57533::apr::update_apr_from_ratio(&mut arg0.id, arg0.apr, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))), 0x2::clock::timestamp_ms(arg2));
    }

    public fun min_reward_redeem(arg0: &0x2::object::UID) : u64 {
        let v0 = MinRewardRedeemKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MinRewardRedeemKey>(arg0, v0)) {
            let v2 = MinRewardRedeemKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MinRewardRedeemKey, u64>(arg0, v2)
        } else {
            1000000
        }
    }

    fun redeem_growth<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0)));
        if (v1 <= arg0.coin_in) {
            return 0x2::balance::zero<T1>()
        };
        let v2 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v1 - arg0.coin_in, v0, v1);
        if (v2 == 0) {
            return 0x2::balance::zero<T1>()
        };
        withdraw_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4)
    }

    fun redeem_growth_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, 0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap))))));
        arg0.apr = 0xb23208de702112f80bc9a36b441c9d5df3be072e7e7157be09d8818cefb57533::apr::update_apr_from_ratio(&mut arg0.id, arg0.apr, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v0), 0x2::clock::timestamp_ms(arg2));
        if (v1 <= arg0.coin_in) {
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        withdraw_staked_sui_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1 - arg0.coin_in, arg5)
    }

    fun redeem_rewards_route<T0, T1, T2, T3: drop>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg6, arg7);
        let v1 = &mut arg0.id;
        let v2 = buffer_join_take<T3>(v1, v0);
        if (0x2::balance::value<T3>(&v2) < min_reward_redeem(&arg0.id)) {
            let v3 = &mut arg0.id;
            buffer_put<T3>(v3, v2);
            return 0x2::balance::zero<T1>()
        };
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg3, 0x2::coin::from_balance<T3>(v2, arg7), arg4, arg7));
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg2, arg5, false, true, 0x2::balance::value<0x2::sui::SUI>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6);
        let v8 = v7;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg2, arg5, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v8)), v8);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, v6);
        let v9 = &mut arg0.id;
        let v10 = buffer_join_take<0x2::sui::SUI>(v9, v4);
        let v11 = &mut arg0.id;
        buffer_put<0x2::sui::SUI>(v11, v10);
        v5
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

    public fun set_min_reward_redeem<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: u64, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        let v0 = MinRewardRedeemKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MinRewardRedeemKey>(&arg0.id, v0)) {
            let v1 = MinRewardRedeemKey{dummy_field: false};
            0x2::dynamic_field::remove<MinRewardRedeemKey, u64>(&mut arg0.id, v1);
        };
        let v2 = MinRewardRedeemKey{dummy_field: false};
        0x2::dynamic_field::add<MinRewardRedeemKey, u64>(&mut arg0.id, v2, arg1);
    }

    public fun set_reward_index_table<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: vector<0x1::type_name::TypeName>, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.reward_index_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg1);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834556595470335);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.reward_index_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    fun swap_rewards_route<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg5, arg6);
        if (0x2::balance::value<T3>(&v0) < 1000000) {
            let v1 = &mut arg0.id;
            buffer_put<T3>(v1, v0);
            return 0x2::balance::zero<T1>()
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T4>(arg2, arg3, true, true, 0x2::balance::value<T3>(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v5 = v4;
        let v6 = v3;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T4>(arg2, arg3, 0x2::balance::split<T3>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T3, T4>(&v5)), 0x2::balance::zero<T4>(), v5);
        0x2::balance::join<T3>(&mut v0, v2);
        let v7 = &mut arg0.id;
        buffer_put<T3>(v7, v0);
        if (0x2::balance::value<T4>(&v6) < 1000000) {
            let v8 = &mut arg0.id;
            buffer_put<T4>(v8, v6);
            return 0x2::balance::zero<T1>()
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T4>(arg2, arg4, false, true, 0x2::balance::value<T4>(&v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v12 = v11;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T4>(arg2, arg4, 0x2::balance::zero<T1>(), 0x2::balance::split<T4>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T4>(&v12)), v12);
        0x2::balance::join<T4>(&mut v6, v10);
        let v13 = &mut arg0.id;
        buffer_put<T4>(v13, v6);
        v9
    }

    public fun update_apr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: u256, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        arg0.apr = arg1;
    }

    fun withdraw_inner<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, arg4, arg5), arg3, arg5))
    }

    public fun withdraw_rbr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::amount<T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_sui_amount<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::fill_rebalance_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_rbr_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::amount<0x2::sui::SUI>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_staked_sui_amount<T0, T1>(arg0, arg2, arg4, arg5, arg6, v0, arg8);
        let v2 = restake_excess<T0, T1>(arg0, arg2, arg4, v1, v0, arg8);
        let v3 = SuilendWitness<T0, T1>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::fill_rebalance_request<0x2::sui::SUI, T1, SuilendWitness<T0, T1>>(arg1, arg3, v2, v3, arg7, arg8);
    }

    fun withdraw_staked_sui_amount<T0, T1>(arg0: &SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1))));
        if (v0 == 0) {
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, v0, arg6), arg3, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg0.reserve_array_index, &v1, arg4, arg6);
        0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg0.reserve_array_index, v1, arg6))
    }

    fun withdraw_sui_amount<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))))));
        withdraw_inner<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg5)
    }

    public fun withdraw_wdr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_coin_amount<T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_sui_amount<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T0, T2>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::fill_withdraw_request<T1, T2, SuilendWitness<T0, T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_wdr_sui<T0, T1>(arg0: &mut SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_coin_amount<0x2::sui::SUI>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_staked_sui_amount<T0, T1>(arg0, arg2, arg4, arg5, arg6, v0, arg8);
        let v2 = restake_excess<T0, T1>(arg0, arg2, arg4, v1, v0, arg8);
        let v3 = SuilendWitness<T0, T1>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::fill_withdraw_request<0x2::sui::SUI, T1, SuilendWitness<T0, T1>>(arg1, arg3, v2, v3, arg7, arg8);
    }

    public fun witness_type<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<SuilendWitness<T0, T1>>()
    }

    // decompiled from Move bytecode v7
}

