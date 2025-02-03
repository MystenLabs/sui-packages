module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::system_portal {
    struct SystemPortal has key {
        id: 0x2::object::UID,
        next_nonce: u64,
    }

    struct SymstemLocalEvent has copy, drop {
        nonce: u64,
        sender: address,
        user_chain_id: u16,
        user_address: vector<u8>,
        call_type: u8,
    }

    public entry fun binding(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut SystemPortal, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::convert_address_to_dola(v0);
        let v2 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg3, arg4);
        if (v1 == v2) {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::register_dola_user_id(arg2, v1);
        } else {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::bind_user_address(arg2, v1, v2);
        };
        let v3 = SymstemLocalEvent{
            nonce         : get_nonce(arg1),
            sender        : v0,
            user_chain_id : arg3,
            user_address  : arg4,
            call_type     : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::system_codec::get_binding_type(),
        };
        0x2::event::emit<SymstemLocalEvent>(v3);
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

    public entry fun unbinding(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut SystemPortal, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::unbind_user_address(arg2, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::convert_address_to_dola(v0), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg3, arg4));
        let v1 = SymstemLocalEvent{
            nonce         : get_nonce(arg1),
            sender        : v0,
            user_chain_id : arg3,
            user_address  : arg4,
            call_type     : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::system_codec::get_unbinding_type(),
        };
        0x2::event::emit<SymstemLocalEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

