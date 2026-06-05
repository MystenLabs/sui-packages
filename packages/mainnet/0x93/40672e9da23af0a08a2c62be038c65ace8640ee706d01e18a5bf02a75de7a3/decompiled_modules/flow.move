module 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::flow {
    public fun allocate_scallop<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>> {
        let v0 = 0x1::vector::empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>();
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&mut arg1);
            let v3 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::to_witness<T1>(&v2);
            if (*0x1::option::borrow<0x1::type_name::TypeName>(&v3) == 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::witness_type<T2>()) {
                0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::allocate_to_protocol<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            } else {
                0x1::vector::push_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(arg1);
        v0
    }

    public fun allocate_suilend<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>> {
        let v0 = 0x1::vector::empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>();
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&mut arg1);
            let v3 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::to_witness<T1>(&v2);
            if (*0x1::option::borrow<0x1::type_name::TypeName>(&v3) == 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::witness_type<T0, T2>()) {
                0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::allocate_to_protocol<T0, T1, T2>(arg2, arg0, arg3, v2, arg4, arg5, arg6);
            } else {
                0x1::vector::push_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T1>>(arg1);
        v0
    }

    public fun approve_scallop<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::approve_protocol_request<T0, T1, T2>(arg2, arg0, arg3, arg4, arg1, arg5, arg6, arg7);
    }

    public fun approve_suilend_lst<T0, T1, T2, T3: drop>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::approve_protocol_request_usdc_lst<T0, T1, T2, T3>(arg2, arg0, arg3, arg1, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg9, arg10);
    }

    public fun approve_suilend_point<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::approve_protocol_request_point<T0, T1, T2>(arg2, arg0, arg3, arg1, arg4, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5, arg6);
    }

    public fun approve_suilend_reward<T0, T1, T2, T3, T4>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T4>, arg7: &0x2::clock::Clock, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::approve_protocol_request_usdc<T0, T1, T2, T3, T4>(arg2, arg0, arg3, arg1, arg4, arg5, arg6, arg7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg8, arg9);
    }

    public fun approve_suilend_sui<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<0x2::sui::SUI>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::approve_protocol_request_sui<T0, T1>(arg2, arg0, arg3, arg1, arg5, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg4, arg6, arg7);
    }

    public fun fill_scallop<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>>(v0, v1);
            if (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<T1>(v2) == 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::witness_type<T2>()) {
                0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::scallop_adapter::withdraw_wdr<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_suilend<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T1, T2>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T1>>(v0, v1);
            if (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<T1>(v2) == 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::witness_type<T0, T2>()) {
                0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::withdraw_wdr<T0, T1, T2>(arg2, arg0, arg3, v2, arg4, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5, arg6);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_suilend_sui<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T1>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>, arg2: &mut 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::SuilendAdapter<T0, 0x2::sui::SUI, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v0, v1);
            if (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<0x2::sui::SUI>(v2) == 0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::witness_type<T0, T1>()) {
                0x9340672e9da23af0a08a2c62be038c65ace8640ee706d01e18a5bf02a75de7a3::suilend_adapter::withdraw_wdr_sui<T0, T1>(arg2, arg0, arg3, v2, arg5, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg4, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

