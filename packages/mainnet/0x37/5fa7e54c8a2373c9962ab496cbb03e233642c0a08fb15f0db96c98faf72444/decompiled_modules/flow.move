module 0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::flow {
    public fun allocate_scallop<T0, T1, T2>(arg0: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg1: vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>, arg2: &mut 0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>> {
        let v0 = 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>();
        0x1::vector::reverse<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(&mut arg1);
            if (0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::to_witness<T1>(&v2) == 0x1::option::some<0x1::type_name::TypeName>(0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::witness_type<T2>())) {
                0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::allocate_to_protocol<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            } else {
                0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(arg1);
        v0
    }

    public fun approve_scallop<T0, T1, T2>(arg0: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRequest<T1>, arg2: &mut 0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::approve_protocol_request<T0, T1, T2>(arg2, arg0, arg3, arg4, arg1, arg5, arg6, arg7);
    }

    public fun fill_rebalance_scallop<T0, T1, T2>(arg0: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg1: vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>, arg2: &mut 0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T1>>(v0, v1);
            if (0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::from_witness<T1>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::witness_type<T2>())) {
                0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::withdraw_rbr<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_scallop<T0, T1, T2>(arg0: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state::SAMState<T1, T2>, arg1: vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T1>>, arg2: &mut 0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::ScallopAdapter<T0, T1, T2>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock, arg6: &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T1>>(v0, v1);
            if (0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::get_witness<T1>(v2) == 0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::witness_type<T2>()) {
                0x375fa7e54c8a2373c9962ab496cbb03e233642c0a08fb15f0db96c98faf72444::scallop_adapter::withdraw_wdr<T0, T1, T2>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

