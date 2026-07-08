module 0xf30930c3f3ba26e6b26ed8bc6caef6e760c62efa6621280da9c4ed9db167babf::bot_auth {
    struct BotPolicy has key {
        id: 0x2::object::UID,
        admin: address,
        authorized_agents: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_agent(arg0: &AdminCap, arg1: &mut BotPolicy, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_set::contains<address>(&arg1.authorized_agents, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.authorized_agents, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = BotPolicy{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            authorized_agents : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<BotPolicy>(v2);
    }

    public entry fun remove_agent(arg0: &AdminCap, arg1: &mut BotPolicy, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_set::contains<address>(&arg1.authorized_agents, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.authorized_agents, &arg2);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &BotPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.authorized_agents, &v0) || v0 == arg1.admin, 0);
    }

    // decompiled from Move bytecode v7
}

