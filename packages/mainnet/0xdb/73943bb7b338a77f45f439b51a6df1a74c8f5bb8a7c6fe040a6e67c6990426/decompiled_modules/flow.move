module 0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::flow {
    public fun allocate_scallop<T0, T1, T2>(arg0: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T1, T2>, arg1: vector<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>, arg2: &mut 0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>> {
        let v0 = 0x1::vector::empty<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>();
        0x1::vector::reverse<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>(&mut arg1);
            let v3 = 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::to_witness<T1>(&v2);
            if (*0x1::option::borrow<0x1::type_name::TypeName>(&v3) == 0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::witness_type<T2>()) {
                0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::allocate_to_protocol<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            } else {
                0x1::vector::push_back<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T1>>(arg1);
        v0
    }

    public fun approve_scallop<T0, T1, T2>(arg0: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T1, T2>, arg1: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::ptr::ProtocolRequest<T1>, arg2: &mut 0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::approve_protocol_request<T0, T1, T2>(arg2, arg0, arg3, arg4, arg1, arg5, arg6, arg7);
    }

    public fun fill_scallop<T0, T1, T2>(arg0: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T1, T2>, arg1: vector<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::WithdrawRequest<T1>>, arg2: &mut 0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::WithdrawRequest<T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::WithdrawRequest<T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::WithdrawRequest<T1>>(v0, v1);
            if (0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::get_witness<T1>(v2) == 0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::witness_type<T2>()) {
                0xdb73943bb7b338a77f45f439b51a6df1a74c8f5bb8a7c6fe040a6e67c6990426::scallop_adapter::withdraw_wdr<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

