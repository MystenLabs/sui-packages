module 0x168c2c138f7055ee959753557ac31e0179e2bf76fc1cb5bd73a06b71c769f1e6::single {
    fun allocate<T0, T1>(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg4: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg5: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg0 == arg1) {
            0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::allocate_to_protocol<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg3, arg5, arg6, arg8, arg9, arg10, arg11, arg12);
        } else {
            assert!(arg0 == arg2, 71);
            0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::allocate_to_protocol<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg4, arg5, arg7, arg9, arg10, arg11, arg12);
        };
    }

    public fun deposit<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg3: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, 0x2::coin::Coin<T2>) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::new_protocol_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg6, arg11);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg4, arg7, &mut v0, arg10, arg6, arg11);
        (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::deposit<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg1, v0, arg6, arg11), 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::approve_protocol_request<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI, T2>(arg3, arg0, arg5, &mut v0, arg8, arg9, arg10, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg6, arg11))
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<u64>, arg4: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg5: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg12: &0x2::clock::Clock, arg13: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::new_protocol_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg8, arg14);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg4, arg0, arg6, arg9, &mut v0, arg12, arg8, arg14);
        let v1 = 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::approve_protocol_request<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI, T2>(arg5, arg0, arg7, &mut v0, arg10, arg11, arg12, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg8, arg14);
        let v2 = 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>();
        let v3 = 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>();
        let v4 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::rebalance<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, v0, arg1, arg2, arg3, arg8, arg13, arg14);
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(&v4)) {
            let v6 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(&mut v4);
            let v7 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::from_witness<0x2::sui::SUI>(&v6);
            let v8 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::to_witness<0x2::sui::SUI>(&v6);
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v7)) {
                allocate<T0, T1>(*0x1::option::borrow<0x1::type_name::TypeName>(&v8), v2, v3, arg4, arg5, arg0, arg6, arg7, arg9, v6, arg12, arg8, arg14);
            } else {
                let v9 = *0x1::option::borrow<0x1::type_name::TypeName>(&v7);
                if (v9 == v2) {
                    0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::withdraw_rbr<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg4, arg0, arg6, arg9, &mut v6, arg12, arg8, arg14);
                } else {
                    assert!(v9 == v3, 71);
                    0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::withdraw_rbr<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg5, arg0, arg7, &mut v6, arg12, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg8, arg14);
                };
                if (0x1::option::is_none<0x1::type_name::TypeName>(&v8)) {
                    0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::reclaim_from_protocol<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, v6, arg8, arg14);
                } else {
                    allocate<T0, T1>(*0x1::option::borrow<0x1::type_name::TypeName>(&v8), v2, v3, arg4, arg5, arg0, arg6, arg7, arg9, v6, arg12, arg8, arg14);
                };
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(v4);
        v1
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg1: 0x2::coin::Coin<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg2: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg3: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T2>) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::new_protocol_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg6, arg11);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg4, arg7, &mut v0, arg10, arg6, arg11);
        let (v1, v2) = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::withdraw<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg1, v0, arg6, arg11);
        let v3 = v2;
        let v4 = &mut v3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v4)) {
            let v6 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v4, v5);
            let v7 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<0x2::sui::SUI>(v6);
            if (v7 == 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>()) {
                0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::withdraw_wdr<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg4, arg7, v6, arg10, arg6, arg11);
            } else {
                assert!(v7 == 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(), 71);
                0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::withdraw_wdr<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg3, arg0, arg5, v6, arg10, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg6, arg11);
            };
            v5 = v5 + 1;
        };
        let v8 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg11);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::consume_withdraw_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, v3, arg6, arg11));
        (v8, 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::approve_protocol_request<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI, T2>(arg3, arg0, arg5, &mut v0, arg8, arg9, arg10, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg6, arg11))
    }

    // decompiled from Move bytecode v7
}

