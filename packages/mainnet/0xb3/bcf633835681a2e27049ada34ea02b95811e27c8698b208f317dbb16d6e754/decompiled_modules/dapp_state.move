module 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state {
    struct Connection has copy, drop, store {
        source: 0x1::string::String,
        destination: 0x1::string::String,
    }

    struct DappState has key {
        id: 0x2::object::UID,
        xcall_cap: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap,
        connections: 0x2::vec_map::VecMap<0x1::string::String, Connection>,
    }

    public(friend) fun new(arg0: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap, arg1: &mut 0x2::tx_context::TxContext) : DappState {
        DappState{
            id          : 0x2::object::new(arg1),
            xcall_cap   : arg0,
            connections : 0x2::vec_map::empty<0x1::string::String, Connection>(),
        }
    }

    public fun add_connection(arg0: &mut DappState, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<0x1::string::String, Connection>(&arg0.connections, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Connection>(&mut arg0.connections, &arg1);
        };
        let v2 = Connection{
            source      : arg2,
            destination : arg3,
        };
        0x2::vec_map::insert<0x1::string::String, Connection>(&mut arg0.connections, arg1, v2);
    }

    public fun get_connection(arg0: &DappState, arg1: 0x1::string::String) : Connection {
        *0x2::vec_map::get<0x1::string::String, Connection>(&arg0.connections, &arg1)
    }

    public fun get_connection_dest(arg0: &Connection) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, arg0.destination);
        v0
    }

    public fun get_connection_source(arg0: &Connection) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, arg0.source);
        v0
    }

    public(friend) fun get_xcall_cap(arg0: &DappState) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        &arg0.xcall_cap
    }

    public fun id(arg0: &DappState) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun id_str(arg0: &DappState) : 0x1::string::String {
        0x2::address::to_string(0x2::object::uid_to_address(&arg0.id))
    }

    public(friend) fun share(arg0: DappState) {
        0x2::transfer::share_object<DappState>(arg0);
    }

    // decompiled from Move bytecode v6
}

