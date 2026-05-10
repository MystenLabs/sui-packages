module 0x98743d02b09274a95e0cd8b7b58fd7b43c132a958387c2fe2b66c795c91c910d::prototype {
    struct IIdentity<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        balances: vector<0x2::table::Table<0x1::string::String, 0x2::balance::Balance<T0>>>,
    }

    struct AgentTable has key {
        id: 0x2::object::UID,
        agents: vector<0x1::string::String>,
    }

    entry fun create_iidentity<T0: store>(arg0: 0x1::string::String, arg1: &mut AgentTable, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::table::Table<0x1::string::String, 0x2::balance::Balance<T0>>>();
        0x1::vector::push_back<0x2::table::Table<0x1::string::String, 0x2::balance::Balance<T0>>>(&mut v0, 0x2::table::new<0x1::string::String, 0x2::balance::Balance<T0>>(arg2));
        let v1 = IIdentity<T0>{
            id       : 0x2::object::new(arg2),
            name     : arg0,
            balances : v0,
        };
        0x2::transfer::share_object<IIdentity<T0>>(v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.agents, arg0);
    }

    entry fun get_iidentity<T0>(arg0: &IIdentity<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentTable{
            id     : 0x2::object::new(arg0),
            agents : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<AgentTable>(v0);
    }

    // decompiled from Move bytecode v7
}

