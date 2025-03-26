module 0x5cf7f0b0548834ec4a11e301402e099cc4311a30423699ec87740c707ad47c31::dapp_state {
    struct Connection has copy, drop, store {
        source: vector<0x1::string::String>,
        destination: vector<0x1::string::String>,
    }

    struct ExecuteParams has drop {
        type_args: vector<0x1::string::String>,
        args: vector<0x1::string::String>,
    }

    struct DappState has key {
        id: 0x2::object::UID,
        xcall_cap: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap,
        xcall_id: 0x2::object::ID,
        connections: 0x2::vec_map::VecMap<0x1::string::String, Connection>,
    }

    public(friend) fun new(arg0: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : DappState {
        DappState{
            id          : 0x2::object::new(arg2),
            xcall_cap   : arg0,
            xcall_id    : arg1,
            connections : 0x2::vec_map::empty<0x1::string::String, Connection>(),
        }
    }

    public fun add_connection(arg0: &mut DappState, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<0x1::string::String, Connection>(&arg0.connections, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, Connection>(&mut arg0.connections, &arg1);
        };
        let v2 = Connection{
            source      : arg2,
            destination : arg3,
        };
        0x2::vec_map::insert<0x1::string::String, Connection>(&mut arg0.connections, arg1, v2);
    }

    public fun create_execute_params(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : ExecuteParams {
        ExecuteParams{
            type_args : arg0,
            args      : arg1,
        }
    }

    public fun get_config_id(arg0: &DappState) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_connection(arg0: &DappState, arg1: 0x1::string::String) : Connection {
        *0x2::vec_map::get<0x1::string::String, Connection>(&arg0.connections, &arg1)
    }

    public fun get_connection_dest(arg0: &Connection) : vector<0x1::string::String> {
        arg0.destination
    }

    public fun get_connection_source(arg0: &Connection) : vector<0x1::string::String> {
        arg0.source
    }

    public(friend) fun get_xcall_cap(arg0: &DappState) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        &arg0.xcall_cap
    }

    public fun get_xcall_id(arg0: &DappState) : 0x2::object::ID {
        arg0.xcall_id
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

