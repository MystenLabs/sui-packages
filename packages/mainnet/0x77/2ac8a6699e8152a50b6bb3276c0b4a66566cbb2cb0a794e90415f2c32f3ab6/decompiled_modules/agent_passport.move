module 0x772ac8a6699e8152a50b6bb3276c0b4a66566cbb2cb0a794e90415f2c32f3ab6::agent_passport {
    struct AgentPassport has store, key {
        id: 0x2::object::UID,
        owner: address,
        suins_name: vector<u8>,
        runtime_wallet: address,
        policy_root: address,
        skill_root: address,
        memory_namespace: vector<u8>,
        is_active: bool,
    }

    public fun create(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : AgentPassport {
        AgentPassport{
            id               : 0x2::object::new(arg2),
            owner            : 0x2::tx_context::sender(arg2),
            suins_name       : arg0,
            runtime_wallet   : arg1,
            policy_root      : @0x0,
            skill_root       : @0x0,
            memory_namespace : b"",
            is_active        : true,
        }
    }

    public fun is_active(arg0: &AgentPassport) : bool {
        arg0.is_active
    }

    public fun revoke(arg0: &mut AgentPassport, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.is_active = false;
    }

    // decompiled from Move bytecode v7
}

