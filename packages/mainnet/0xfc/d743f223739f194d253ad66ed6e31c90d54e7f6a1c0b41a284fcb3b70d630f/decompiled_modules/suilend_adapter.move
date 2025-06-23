module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::suilend_adapter {
    struct SuilendWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct SuilendAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        reserve_array_index: u64,
        reward_index_table: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        reward_pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public fun new<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<0x1::type_name::TypeName>, arg5: vector<0x2::object::ID>, arg6: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::acl::AdminWitness<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam::SAM>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg7);
        let v1 = 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg7);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834359026974719);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v0, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::reverse<0x2::object::ID>(&mut arg5);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg4) == 0x1::vector::length<0x2::object::ID>(&arg5), 13906834376206843903);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg4);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&arg4)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v1, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg4), 0x1::vector::pop_back<0x2::object::ID>(&mut arg5));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg4);
        0x1::vector::destroy_empty<0x2::object::ID>(arg5);
        let v4 = SuilendAdapter<T0, T1, T2>{
            id                   : 0x2::object::new(arg7),
            coin_in              : 0,
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg7),
            reserve_array_index  : arg1,
            reward_index_table   : v0,
            reward_pool_table    : v1,
        };
        0x2::transfer::public_share_object<SuilendAdapter<T0, T1, T2>>(v4);
    }

    fun claim_rewards<T0, T1, T2, T3>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T3>(arg1, &arg0.obligation_owner_cap, arg2, arg0.reserve_array_index, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_index_table, 0x1::type_name::get<T3>()), true, arg3))
    }

    public fun allocate_to_protocol<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T1>, arg4: &0x2::clock::Clock, arg5: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendWitness<T2>{dummy_field: false};
        let v1 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::allocate_to_protocol<T1, T2, SuilendWitness<T2>>(arg1, arg3, v0, arg5, arg6);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T1>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg0.reserve_array_index, arg4, 0x2::coin::from_balance<T1>(v1, arg6), arg6), arg6);
    }

    public fun approve_protocol_request<T0, T1, T2, T3>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg6: &0x2::clock::Clock, arg7: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1) = swap_rewards<T0, T1, T2, T3>(arg0, arg2, arg4, arg5, arg6, arg8);
        let v2 = SuilendWitness<T2>{dummy_field: false};
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::approve_protocol_request<T1, T2, SuilendWitness<T2>>(arg1, arg3, get_available_liquidity<T0, T1, T2>(arg0, arg2), get_apr<T0, T1>(arg2), v0, v2, arg7, arg8);
        0x2::coin::from_balance<T3>(v1, arg8)
    }

    public fun approve_protocol_request_three_rewards<T0, T1, T2, T3, T4, T5>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T5>, arg8: &0x2::clock::Clock, arg9: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        let (v0, v1) = swap_rewards<T0, T1, T2, T3>(arg0, arg2, arg4, arg5, arg8, arg10);
        let v2 = v0;
        let (v3, v4) = swap_rewards<T0, T1, T2, T4>(arg0, arg2, arg4, arg6, arg8, arg10);
        let (v5, v6) = swap_rewards<T0, T1, T2, T5>(arg0, arg2, arg4, arg7, arg8, arg10);
        0x2::balance::join<T1>(&mut v2, v3);
        0x2::balance::join<T1>(&mut v2, v5);
        let v7 = SuilendWitness<T2>{dummy_field: false};
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::approve_protocol_request<T1, T2, SuilendWitness<T2>>(arg1, arg3, get_available_liquidity<T0, T1, T2>(arg0, arg2), get_apr<T0, T1>(arg2), v2, v7, arg9, arg10);
        (0x2::coin::from_balance<T3>(v1, arg10), 0x2::coin::from_balance<T4>(v4, arg10), 0x2::coin::from_balance<T5>(v6, arg10))
    }

    public fun approve_protocol_request_two_rewards<T0, T1, T2, T3, T4>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg7: &0x2::clock::Clock, arg8: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        let (v0, v1) = swap_rewards<T0, T1, T2, T3>(arg0, arg2, arg4, arg5, arg7, arg9);
        let v2 = v0;
        let (v3, v4) = swap_rewards<T0, T1, T2, T4>(arg0, arg2, arg4, arg6, arg7, arg9);
        0x2::balance::join<T1>(&mut v2, v3);
        let v5 = SuilendWitness<T2>{dummy_field: false};
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::approve_protocol_request<T1, T2, SuilendWitness<T2>>(arg1, arg3, get_available_liquidity<T0, T1, T2>(arg0, arg2), get_apr<T0, T1>(arg2), v2, v5, arg8, arg9);
        (0x2::coin::from_balance<T3>(v1, arg9), 0x2::coin::from_balance<T4>(v4, arg9))
    }

    public fun get_apr<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::calculate_utilization_rate<T0>(v0);
        0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::from_u64(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::calculate_supply_apr(v1, v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::calculate_apr(v1, v2))))
    }

    public fun get_available_liquidity<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1));
        let v1 = if (v0 < arg0.coin_in) {
            v0
        } else {
            arg0.coin_in
        };
        0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::from_u64(v1)
    }

    public fun set_reward_index_table<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: vector<0x1::type_name::TypeName>, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>) {
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.reward_index_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg1);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834479286059007);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.reward_index_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun set_reward_pool_table<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: vector<0x1::type_name::TypeName>, arg2: vector<0x1::type_name::TypeName>, arg3: vector<0x2::object::ID>) {
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg1);
        0x1::vector::reverse<0x2::object::ID>(&mut arg3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2) == 0x1::vector::length<0x2::object::ID>(&arg3), 13906834543710568447);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg2), 0x1::vector::pop_back<0x2::object::ID>(&mut arg3));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg2);
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
    }

    fun swap_rewards<T0, T1, T2, T3>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T3>) {
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, 0x1::type_name::get<T3>()) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>>(arg3), 13906835681876901887);
        let v0 = claim_rewards<T0, T1, T2, T3>(arg0, arg1, arg4, arg5);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg2, arg3, false, true, 0x2::balance::value<T3>(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4);
        let v4 = v3;
        let v5 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T3>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T3>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T3>(&v4)), v4);
        0x2::balance::join<T3>(&mut v5, v0);
        (v1, v5)
    }

    fun withdraw_inner<T0, T1, T2>(arg0: &SuilendAdapter<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_array_index, &arg0.obligation_owner_cap, arg2, arg4, arg5), arg3, arg5))
    }

    public fun withdraw_rbr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::amount<T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_inner<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T2>{dummy_field: false};
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::fill_rebalance_request<T1, T2, SuilendWitness<T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    public fun withdraw_wdr<T0, T1, T2>(arg0: &mut SuilendAdapter<T0, T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::SAMState<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T1>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::get_coin_amount<T1>(arg3);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = withdraw_inner<T0, T1, T2>(arg0, arg2, arg4, arg5, v0, arg7);
        let v2 = SuilendWitness<T2>{dummy_field: false};
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state::fill_withdraw_request<T1, T2, SuilendWitness<T2>>(arg1, arg3, v1, v2, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

