module 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::axelar_router {
    struct AxelarRouterAdminCap has store, key {
        id: 0x2::object::UID,
        router_id: 0x2::object::ID,
        whitelist_admin_cap: 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::whitelist::WhitelistAdminCap,
    }

    struct AxelarRouter has store, key {
        id: 0x2::object::UID,
        whitelist: 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::whitelist::Whitelist,
        write_u256_channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
        axelar_chain_id_to_string: 0x2::table::Table<u32, 0x1::ascii::String>,
        axelar_chain_string_to_id: 0x2::table::Table<0x1::ascii::String, u32>,
        axelar_chain_id_to_peer_router: 0x2::table::Table<u32, 0x1::ascii::String>,
    }

    struct WriteU256Received has copy, drop {
        value: u256,
        source_chain: 0x1::ascii::String,
        message_id: 0x1::ascii::String,
        source_address: 0x1::ascii::String,
        payload: vector<u8>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AxelarRouterAdminCap {
        let (v0, v1) = 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::whitelist::new(arg0);
        let v2 = AxelarRouter{
            id                             : 0x2::object::new(arg0),
            whitelist                      : v0,
            write_u256_channel             : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg0),
            axelar_chain_id_to_string      : 0x2::table::new<u32, 0x1::ascii::String>(arg0),
            axelar_chain_string_to_id      : 0x2::table::new<0x1::ascii::String, u32>(arg0),
            axelar_chain_id_to_peer_router : 0x2::table::new<u32, 0x1::ascii::String>(arg0),
        };
        let v3 = AxelarRouterAdminCap{
            id                  : 0x2::object::new(arg0),
            router_id           : 0x2::object::id<AxelarRouter>(&v2),
            whitelist_admin_cap : v1,
        };
        0x2::transfer::share_object<AxelarRouter>(v2);
        v3
    }

    fun assert_correct_axelar_router_admin_cap(arg0: &AxelarRouterAdminCap, arg1: &AxelarRouter) {
        assert!(arg0.router_id == 0x2::object::id<AxelarRouter>(arg1), 0);
    }

    public fun borrow_whitelist_mut(arg0: &mut AxelarRouter) : &mut 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::whitelist::Whitelist {
        &mut arg0.whitelist
    }

    fun get_destination_chain_string(arg0: &AxelarRouter, arg1: u32) : 0x1::ascii::String {
        assert!(0x2::table::contains<u32, 0x1::ascii::String>(&arg0.axelar_chain_id_to_string, arg1), 1);
        *0x2::table::borrow<u32, 0x1::ascii::String>(&arg0.axelar_chain_id_to_string, arg1)
    }

    fun get_peer_router(arg0: &AxelarRouter, arg1: u32) : 0x1::ascii::String {
        assert!(0x2::table::contains<u32, 0x1::ascii::String>(&arg0.axelar_chain_id_to_peer_router, arg1), 2);
        *0x2::table::borrow<u32, 0x1::ascii::String>(&arg0.axelar_chain_id_to_string, arg1)
    }

    public fun register_write_u256(arg0: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg1: &AxelarRouter) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, x"02");
        0x1::vector::push_back<vector<u8>>(v1, 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::concat::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<AxelarRouter>(arg1))));
        let v2 = 0x1::type_name::get<AxelarRouter>();
        let v3 = 0x1::type_name::get_address(&v2);
        let v4 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v4, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v3))), 0x1::ascii::string(b"axelar_router"), 0x1::ascii::string(b"write_u256")), v0, 0x1::vector::empty<0x1::ascii::String>()));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg0, &arg1.write_u256_channel, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v4));
    }

    public fun send(arg0: &AxelarRouter, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::Gateway, arg2: 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::message::Message) {
        let v0 = 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::message::bridge(arg2);
        if (0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::bridge::is_axelar(&v0)) {
            let v1 = 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::message::chain_id(arg2);
            let v2 = 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::message::destination(arg2);
            let v3 = 0x2::bcs::to_bytes<address>(&v2);
            let v4 = 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::message::payload(arg2);
            0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<vector<u8>>(&v4));
            0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::send_message(arg1, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::prepare_message(&arg0.write_u256_channel, get_destination_chain_string(arg0, v1), get_peer_router(arg0, v1), v3));
            return
        } else {
            assert!(0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::bridge::is_null(&v0), 3);
            abort 9999
        };
    }

    public fun set_axelar_chain_string(arg0: &AxelarRouterAdminCap, arg1: &mut AxelarRouter, arg2: u32, arg3: 0x1::ascii::String) {
        assert_correct_axelar_router_admin_cap(arg0, arg1);
        0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::table::update_or_add_in_table<u32, 0x1::ascii::String>(&mut arg1.axelar_chain_id_to_string, arg2, arg3);
        0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::table::update_or_add_in_table<0x1::ascii::String, u32>(&mut arg1.axelar_chain_string_to_id, arg3, arg2);
    }

    public fun set_peer_router(arg0: &AxelarRouterAdminCap, arg1: &mut AxelarRouter, arg2: u32, arg3: 0x1::ascii::String) {
        assert_correct_axelar_router_admin_cap(arg0, arg1);
        0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::table::update_or_add_in_table<u32, 0x1::ascii::String>(&mut arg1.axelar_chain_id_to_peer_router, arg2, arg3);
    }

    public fun write_u256(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg1: &mut AxelarRouter) {
        let (v0, v1, v2, v3) = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::consume_approved_message(&arg1.write_u256_channel, arg0);
        let v4 = 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::abi::new_reader(v3);
        let v5 = WriteU256Received{
            value          : 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::abi::read_u256(&mut v4),
            source_chain   : v0,
            message_id     : v1,
            source_address : v2,
            payload        : v3,
        };
        0x2::event::emit<WriteU256Received>(v5);
    }

    // decompiled from Move bytecode v6
}

