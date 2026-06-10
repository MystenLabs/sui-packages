module 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::flow {
    public fun allocate_suilend<T0, T1, T2>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>> {
        let v0 = 0x1::vector::empty<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>();
        0x1::vector::reverse<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(&mut arg1);
            if (0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::to_witness<T1, T2>(&v2) == 0x1::option::some<0x1::type_name::TypeName>(0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::witness_type<T0, T2>())) {
                0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::allocate_to_protocol<T0, T1, T2>(arg2, arg0, arg3, v2, arg4, arg5, arg6);
            } else {
                0x1::vector::push_back<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(arg1);
        v0
    }

    public fun approve_suilend<T0, T1, T2>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<T1>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::end_approve<T0, T1, T2>(arg2, arg0, arg1, 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::begin_approve<T0, T1, T2>(arg2, arg0, arg3, arg4, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg6), arg4, arg5, arg6);
    }

    public fun approve_suilend_lst<T0, T1, T2, T3: drop>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<T1>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::begin_approve<T0, T1, T2>(arg2, arg0, arg3, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg10);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::harvest_reward_lst<T0, T1, T2, T3>(arg2, &mut v0, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::end_approve<T0, T1, T2>(arg2, arg0, arg1, v0, arg8, arg9, arg10);
    }

    public fun approve_suilend_reward<T0, T1, T2, T3, T4>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<T1>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg7: &0x2::clock::Clock, arg8: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::begin_approve<T0, T1, T2>(arg2, arg0, arg3, arg7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg9);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::harvest_reward<T0, T1, T2, T3, T4>(arg2, &mut v0, arg3, arg4, arg5, arg6, arg7, arg9);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::end_approve<T0, T1, T2>(arg2, arg0, arg1, v0, arg7, arg8, arg9);
    }

    public fun approve_suilend_reward_direct<T0, T1, T2, T3>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<T1>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg6: &0x2::clock::Clock, arg7: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::begin_approve<T0, T1, T2>(arg2, arg0, arg3, arg6, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg8);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::harvest_reward_direct<T0, T1, T2, T3>(arg2, &mut v0, arg3, arg4, arg5, arg6, arg8);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::end_approve<T0, T1, T2>(arg2, arg0, arg1, v0, arg6, arg7, arg8);
    }

    public fun approve_suilend_sui<T0, T1>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<0x2::sui::SUI, T1>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<0x2::sui::SUI>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::end_approve<T0, 0x2::sui::SUI, T1>(arg2, arg0, arg1, 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::begin_approve_sui<T0, T1>(arg2, arg0, arg3, arg5, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg4, arg7), arg5, arg6, arg7);
    }

    public fun approve_suilend_sui_lst<T0, T1, T2: drop>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<0x2::sui::SUI, T1>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<0x2::sui::SUI>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::begin_approve_sui<T0, T1>(arg2, arg0, arg3, arg6, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg5, arg8);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::harvest_reward_lst_native<T0, T1, T2>(arg2, &mut v0, arg3, arg4, arg5, arg6, arg8);
        0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::end_approve<T0, 0x2::sui::SUI, T1>(arg2, arg0, arg1, v0, arg6, arg7, arg8);
    }

    public fun fill_rebalance_suilend<T0, T1, T2>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T1, T2>>(v0, v1);
            if (0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::from_witness<T1, T2>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::witness_type<T0, T2>())) {
                0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::withdraw_rbr<T0, T1, T2>(arg2, arg0, arg3, v2, arg4, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5, arg6);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_rebalance_suilend_sui<T0, T1>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<0x2::sui::SUI, T1>, arg1: vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<0x2::sui::SUI, T1>>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<0x2::sui::SUI, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<0x2::sui::SUI, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<0x2::sui::SUI, T1>>(v0, v1);
            if (0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::from_witness<0x2::sui::SUI, T1>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::witness_type<T0, T1>())) {
                0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::withdraw_rbr_sui<T0, T1>(arg2, arg0, arg3, v2, arg5, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg4, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_suilend<T0, T1, T2>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T1, T2>, arg1: vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<T1, T2>>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<T1, T2>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<T1, T2>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<T1, T2>>(v0, v1);
            if (0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::get_witness<T1, T2>(v2) == 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::witness_type<T0, T2>()) {
                0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::withdraw_wdr<T0, T1, T2>(arg2, arg0, arg3, v2, arg4, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5, arg6);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_suilend_sui<T0, T1>(arg0: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<0x2::sui::SUI, T1>, arg1: vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<0x2::sui::SUI, T1>>, arg2: &mut 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<0x2::sui::SUI, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<0x2::sui::SUI, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<0x2::sui::SUI, T1>>(v0, v1);
            if (0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::get_witness<0x2::sui::SUI, T1>(v2) == 0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::witness_type<T0, T1>()) {
                0xd02edc0b5d0033109fe412228383e257f8e14c6c4ba996c5e7f2d5ff1e65f18e::suilend_adapter::withdraw_wdr_sui<T0, T1>(arg2, arg0, arg3, v2, arg5, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg4, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

