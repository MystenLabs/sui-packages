module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_wormhole_adapter {
    struct SystemCoreEvent has copy, drop {
        nonce: u64,
        sender: vector<u8>,
        source_chain_id: u16,
        user_chain_id: u16,
        user_address: vector<u8>,
        call_type: u8,
    }

    public entry fun bind_user_address(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg4: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_storage::Storage, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::receive_message(arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_storage::get_app_cap(arg4), arg5, arg6, arg7);
        let v2 = v0;
        let (v3, v4, v5, v6) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_codec::decode_bind_payload(v1);
        let v7 = v5;
        assert!(v6 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_codec::get_binding_type(), 0);
        if (v2 == v7) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_user_id(arg1, v2);
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::bind_user_address(arg1, v2, v7);
        };
        let v8 = SystemCoreEvent{
            nonce           : v4,
            sender          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v2),
            source_chain_id : v3,
            user_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_chain_id(&v7),
            user_address    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v7),
            call_type       : v6,
        };
        0x2::event::emit<SystemCoreEvent>(v8);
    }

    public entry fun unbind_user_address(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg4: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_storage::Storage, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::receive_message(arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_storage::get_app_cap(arg4), arg5, arg6, arg7);
        let v2 = v0;
        let (v3, v4, v5, v6) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_codec::decode_bind_payload(v1);
        let v7 = v5;
        assert!(v6 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_codec::get_unbinding_type(), 0);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::unbind_user_address(arg1, v2, v7);
        let v8 = SystemCoreEvent{
            nonce           : v4,
            sender          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v2),
            source_chain_id : v3,
            user_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_chain_id(&v7),
            user_address    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v7),
            call_type       : v6,
        };
        0x2::event::emit<SystemCoreEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

