module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_portal {
    struct SystemPortal has key {
        id: 0x2::object::UID,
        next_nonce: u64,
    }

    struct SystemLocalEvent has copy, drop {
        nonce: u64,
        sender: address,
        user_chain_id: u16,
        user_address: vector<u8>,
        call_type: u8,
    }

    public entry fun binding(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut SystemPortal, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4);
        if (v1 == v2) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_user_id(arg2, v1);
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::bind_user_address(arg2, v1, v2);
        };
        let v3 = SystemLocalEvent{
            nonce         : get_nonce(arg1),
            sender        : v0,
            user_chain_id : arg3,
            user_address  : arg4,
            call_type     : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_codec::get_binding_type(),
        };
        0x2::event::emit<SystemLocalEvent>(v3);
    }

    fun get_nonce(arg0: &mut SystemPortal) : u64 {
        arg0.next_nonce = arg0.next_nonce + 1;
        arg0.next_nonce
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SystemPortal{
            id         : 0x2::object::new(arg0),
            next_nonce : 0,
        };
        0x2::transfer::share_object<SystemPortal>(v0);
    }

    public entry fun unbinding(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut SystemPortal, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::unbind_user_address(arg2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4));
        let v1 = SystemLocalEvent{
            nonce         : get_nonce(arg1),
            sender        : v0,
            user_chain_id : arg3,
            user_address  : arg4,
            call_type     : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_codec::get_unbinding_type(),
        };
        0x2::event::emit<SystemLocalEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

