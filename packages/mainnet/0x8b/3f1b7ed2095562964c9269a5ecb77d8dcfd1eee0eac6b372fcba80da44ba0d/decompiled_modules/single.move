module 0x8b3f1b7ed2095562964c9269a5ecb77d8dcfd1eee0eac6b372fcba80da44ba0d::single {
    public fun deposit<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg3: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AV, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI> {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::get_allowed_versions(arg9);
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::new_protocol_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, &v0, arg10);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg4, arg5, &mut v1, arg8, &v0, arg10);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::approve_protocol_request_sui<T1, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg3, arg0, arg6, &mut v1, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg7, &v0, arg10);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::deposit<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg1, v1, &v0, arg10)
    }

    public fun rebalance<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg1: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg2: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AV, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::get_allowed_versions(arg8);
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::new_protocol_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, &v0, arg9);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg1, arg0, arg3, arg4, &mut v1, arg7, &v0, arg9);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::approve_protocol_request_sui<T1, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg5, &mut v1, arg7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg6, &v0, arg9);
        let v2 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::rebalance_optimal<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, v1, &v0, arg9);
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(&v2)) {
            let v4 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(&mut v2);
            let v5 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::to_witness<0x2::sui::SUI>(&v4);
            let v6 = *0x1::option::borrow<0x1::type_name::TypeName>(&v5);
            if (v6 == 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>()) {
                0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::allocate_to_protocol<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg1, arg0, arg3, arg4, v4, arg7, &v0, arg9);
            } else {
                assert!(v6 == 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(), 71);
                0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::allocate_to_protocol<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg5, v4, arg7, &v0, arg9);
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<0x2::sui::SUI>>(v2);
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg1: 0x2::coin::Coin<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg2: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg3: &mut 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AV, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::get_allowed_versions(arg9);
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::new_protocol_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, &v0, arg10);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg4, arg5, &mut v1, arg8, &v0, arg10);
        0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::approve_protocol_request_sui<T1, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg3, arg0, arg6, &mut v1, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg7, &v0, arg10);
        let (v2, v3) = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::withdraw<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, arg1, v1, &v0, arg10);
        let v4 = v3;
        let v5 = &mut v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v5)) {
            let v7 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v5, v6);
            let v8 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<0x2::sui::SUI>(v7);
            if (v8 == 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>()) {
                0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::scallop_adapter::withdraw_wdr<T0, 0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg2, arg0, arg4, arg5, v7, arg8, &v0, arg10);
            } else {
                assert!(v8 == 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::witness_type<0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(), 71);
                0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::suilend_adapter::withdraw_wdr_sui<T1, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg3, arg0, arg6, v7, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg7, &v0, arg10);
            };
            v6 = v6 + 1;
        };
        let v9 = 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg10);
        0x2::coin::join<0x2::sui::SUI>(&mut v9, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::consume_withdraw_request<0x2::sui::SUI, 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui::SAMSUI>(arg0, v4, &v0, arg10));
        v9
    }

    // decompiled from Move bytecode v7
}

