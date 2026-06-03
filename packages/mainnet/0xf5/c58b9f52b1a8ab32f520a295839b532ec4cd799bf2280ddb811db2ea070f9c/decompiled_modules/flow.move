module 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::flow {
    public fun allocate<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>, arg2: &mut 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>(&mut arg1);
            let v2 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::to_witness<T0>(&v1);
            assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&v2) == 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::witness_type<T1>(), 71);
            0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::allocate_to_protocol<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, v1, arg8, arg9);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>(arg1);
    }

    public fun fill<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>, arg2: &mut 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v0, v1);
            if (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<T0>(v2) == 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::witness_type<T1>()) {
                0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::withdraw_wdr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, v2, arg9, arg10);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_sui<T0, T1>(arg0: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>, arg2: &mut 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v0, v1);
            if (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<T0>(v2) == 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::witness_type<T1>()) {
                0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter::withdraw_wdr_sui<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v2, arg10, arg11);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

