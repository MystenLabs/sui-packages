module 0x3ea4bbe34cf8fbe215dc4cebeb9b1525d642fccbb1bc374e526fa75ea1d18137::agent_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        agents: 0x2::table::Table<address, AgentInfo>,
        agent_count: u64,
        total_distributed: u64,
    }

    struct AgentInfo has copy, drop, store {
        owner: address,
        created_at: u64,
        initial_allocation: u64,
        name: vector<u8>,
        is_active: bool,
    }

    struct AgentRegistered has copy, drop {
        agent_address: address,
        owner: address,
        initial_allocation: u64,
        name: vector<u8>,
    }

    struct AgentTingMinted has copy, drop {
        agent_address: address,
        amount: u64,
    }

    public fun agent_count(arg0: &AgentRegistry) : u64 {
        arg0.agent_count
    }

    public fun deactivate_agent(arg0: &AdminCap, arg1: &mut AgentRegistry, arg2: address) {
        assert!(0x2::table::contains<address, AgentInfo>(&arg1.agents, arg2), 1);
        0x2::table::borrow_mut<address, AgentInfo>(&mut arg1.agents, arg2).is_active = false;
    }

    public fun get_agent_owner(arg0: &AgentRegistry, arg1: address) : address {
        assert!(0x2::table::contains<address, AgentInfo>(&arg0.agents, arg1), 1);
        0x2::table::borrow<address, AgentInfo>(&arg0.agents, arg1).owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AgentRegistry{
            id                : 0x2::object::new(arg0),
            agents            : 0x2::table::new<address, AgentInfo>(arg0),
            agent_count       : 0,
            total_distributed : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AgentRegistry>(v1);
    }

    public fun is_active(arg0: &AgentRegistry, arg1: address) : bool {
        if (!0x2::table::contains<address, AgentInfo>(&arg0.agents, arg1)) {
            return false
        };
        0x2::table::borrow<address, AgentInfo>(&arg0.agents, arg1).is_active
    }

    public fun is_agent(arg0: &AgentRegistry, arg1: address) : bool {
        0x2::table::contains<address, AgentInfo>(&arg0.agents, arg1)
    }

    public fun reactivate_agent(arg0: &AdminCap, arg1: &mut AgentRegistry, arg2: address) {
        assert!(0x2::table::contains<address, AgentInfo>(&arg1.agents, arg2), 1);
        0x2::table::borrow_mut<address, AgentInfo>(&mut arg1.agents, arg2).is_active = true;
    }

    public fun register_agent(arg0: &AdminCap, arg1: &mut AgentRegistry, arg2: &mut 0x2::coin::TreasuryCap<0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting::TING>, arg3: address, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, AgentInfo>(&arg1.agents, arg3), 0);
        let v0 = AgentInfo{
            owner              : arg4,
            created_at         : 0x2::tx_context::epoch(arg6),
            initial_allocation : 100000000000,
            name               : arg5,
            is_active          : true,
        };
        0x2::table::add<address, AgentInfo>(&mut arg1.agents, arg3, v0);
        arg1.agent_count = arg1.agent_count + 1;
        arg1.total_distributed = arg1.total_distributed + 100000000000;
        0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting::mint(arg2, 100000000000, arg3, arg6);
        let v1 = AgentRegistered{
            agent_address      : arg3,
            owner              : arg4,
            initial_allocation : 100000000000,
            name               : arg5,
        };
        0x2::event::emit<AgentRegistered>(v1);
        let v2 = AgentTingMinted{
            agent_address : arg3,
            amount        : 100000000000,
        };
        0x2::event::emit<AgentTingMinted>(v2);
    }

    public fun register_agent_with_allocation(arg0: &AdminCap, arg1: &mut AgentRegistry, arg2: &mut 0x2::coin::TreasuryCap<0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting::TING>, arg3: address, arg4: address, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, AgentInfo>(&arg1.agents, arg3), 0);
        let v0 = AgentInfo{
            owner              : arg4,
            created_at         : 0x2::tx_context::epoch(arg7),
            initial_allocation : arg6,
            name               : arg5,
            is_active          : true,
        };
        0x2::table::add<address, AgentInfo>(&mut arg1.agents, arg3, v0);
        arg1.agent_count = arg1.agent_count + 1;
        arg1.total_distributed = arg1.total_distributed + arg6;
        0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting::mint(arg2, arg6, arg3, arg7);
        let v1 = AgentRegistered{
            agent_address      : arg3,
            owner              : arg4,
            initial_allocation : arg6,
            name               : arg5,
        };
        0x2::event::emit<AgentRegistered>(v1);
        let v2 = AgentTingMinted{
            agent_address : arg3,
            amount        : arg6,
        };
        0x2::event::emit<AgentTingMinted>(v2);
    }

    public fun reward_agent(arg0: &AdminCap, arg1: &AgentRegistry, arg2: &mut 0x2::coin::TreasuryCap<0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting::TING>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, AgentInfo>(&arg1.agents, arg3), 1);
        0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting::mint(arg2, arg4, arg3, arg5);
        let v0 = AgentTingMinted{
            agent_address : arg3,
            amount        : arg4,
        };
        0x2::event::emit<AgentTingMinted>(v0);
    }

    public fun total_distributed(arg0: &AgentRegistry) : u64 {
        arg0.total_distributed
    }

    // decompiled from Move bytecode v6
}

