module 0xe9adc8b39b061dc850149f4ba2fcdf2c49d59306f6f91d5d93af053ae7981822::agent_acl {
    struct Access has store, key {
        id: 0x2::object::UID,
    }

    struct AgentAdapterAcl has key {
        id: 0x2::object::UID,
        access: Access,
    }

    public(friend) fun access(arg0: &AgentAdapterAcl) : &Access {
        &arg0.access
    }

    public(friend) fun acl_id(arg0: &AgentAdapterAcl) : 0x2::object::ID {
        0x2::object::id<Access>(&arg0.access)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Access{id: 0x2::object::new(arg0)};
        let v1 = AgentAdapterAcl{
            id     : 0x2::object::new(arg0),
            access : v0,
        };
        0x2::transfer::share_object<AgentAdapterAcl>(v1);
    }

    // decompiled from Move bytecode v6
}

