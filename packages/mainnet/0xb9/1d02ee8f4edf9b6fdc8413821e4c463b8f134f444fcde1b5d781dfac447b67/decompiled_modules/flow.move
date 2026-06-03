module 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::flow {
    public fun allocate<T0, T1, T2, T3>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T2, T3>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>, arg2: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::ScallopAdapter<T0, T2, T3>, arg3: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::SuilendAdapter<T1, T2, T3>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x2::clock::Clock, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>> {
        let v0 = 0x1::vector::empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>();
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>(&mut arg1);
            let v3 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::to_witness<T2>(&v2);
            let v4 = *0x1::option::borrow<0x1::type_name::TypeName>(&v3);
            if (v4 == 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::witness_type<T3>()) {
                0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::allocate_to_protocol<T0, T2, T3>(arg2, arg0, arg4, arg5, v2, arg7, arg8, arg9);
            } else if (v4 == 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::witness_type<T3>()) {
                0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::allocate_to_protocol<T1, T2, T3>(arg3, arg0, arg6, v2, arg7, arg8, arg9);
            } else {
                0x1::vector::push_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T2>>(arg1);
        v0
    }

    public fun approve<T0, T1, T2, T3>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T2, T3>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T2>, arg2: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::ScallopAdapter<T0, T2, T3>, arg3: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::SuilendAdapter<T1, T2, T3>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x2::clock::Clock, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::approve_protocol_request<T0, T2, T3>(arg2, arg0, arg4, arg5, arg1, arg7, arg8, arg9);
        0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::approve_protocol_request_point<T1, T2, T3>(arg3, arg0, arg6, arg1, arg7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, T2>>(), arg8, arg9);
    }

    public fun approve_sui<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<0x2::sui::SUI>, arg2: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, T2>, arg3: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, T2>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::approve_protocol_request<T0, 0x2::sui::SUI, T2>(arg2, arg0, arg4, arg5, arg1, arg8, arg9, arg10);
        0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::approve_protocol_request_sui<T1, T2>(arg3, arg0, arg6, arg1, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg7, arg9, arg10);
    }

    public fun fill<T0, T1, T2, T3>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T2, T3>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T2>>, arg2: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::ScallopAdapter<T0, T2, T3>, arg3: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::SuilendAdapter<T1, T2, T3>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x2::clock::Clock, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T2>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T2>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T2>>(v0, v1);
            let v3 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<T2>(v2);
            if (v3 == 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::witness_type<T3>()) {
                0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::withdraw_wdr<T0, T2, T3>(arg2, arg0, arg4, arg5, v2, arg7, arg8, arg9);
            } else if (v3 == 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::witness_type<T3>()) {
                0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::withdraw_wdr<T1, T2, T3>(arg3, arg0, arg6, v2, arg7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, T2>>(), arg8, arg9);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_sui<T0, T1, T2>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<0x2::sui::SUI, T2>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>, arg2: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::ScallopAdapter<T0, 0x2::sui::SUI, T2>, arg3: &mut 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::SuilendAdapter<T1, 0x2::sui::SUI, T2>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<0x2::sui::SUI>>(v0, v1);
            let v3 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<0x2::sui::SUI>(v2);
            if (v3 == 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::witness_type<T2>()) {
                0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::scallop_adapter::withdraw_wdr<T0, 0x2::sui::SUI, T2>(arg2, arg0, arg4, arg5, v2, arg8, arg9, arg10);
            } else if (v3 == 0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::witness_type<T2>()) {
                0xb91d02ee8f4edf9b6fdc8413821e4c463b8f134f444fcde1b5d781dfac447b67::suilend_adapter::withdraw_wdr_sui<T1, T2>(arg3, arg0, arg6, v2, arg8, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg7, arg9, arg10);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

