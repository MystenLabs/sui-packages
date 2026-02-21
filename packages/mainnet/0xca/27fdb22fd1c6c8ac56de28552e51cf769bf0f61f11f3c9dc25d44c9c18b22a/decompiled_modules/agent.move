module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agent {
    struct Agent has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        mcp_endpoint: 0x1::string::String,
        fee_per_task_bps: u64,
        tasks_completed: u64,
        total_earned: u64,
        reputation_score: u64,
        active: bool,
        registered_at: u64,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        total_agents: u64,
        active_agents: u64,
    }

    struct AgentRegistered has copy, drop {
        agent_id: address,
        owner: address,
        name: 0x1::string::String,
        mcp_endpoint: 0x1::string::String,
    }

    struct AgentDeactivated has copy, drop {
        agent_id: address,
        owner: address,
    }

    struct AgentUpdated has copy, drop {
        agent_id: address,
        field: 0x1::string::String,
    }

    public fun active_agents(arg0: &AgentRegistry) : u64 {
        arg0.active_agents
    }

    entry fun deactivate_agent(arg0: &mut Agent, arg1: &mut AgentRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 200);
        assert!(arg0.active, 201);
        arg0.active = false;
        arg1.active_agents = arg1.active_agents - 1;
        let v0 = AgentDeactivated{
            agent_id : 0x2::object::uid_to_address(&arg0.id),
            owner    : arg0.owner,
        };
        0x2::event::emit<AgentDeactivated>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentRegistry{
            id            : 0x2::object::new(arg0),
            total_agents  : 0,
            active_agents : 0,
        };
        0x2::transfer::share_object<AgentRegistry>(v0);
    }

    public fun is_active(arg0: &Agent) : bool {
        arg0.active
    }

    public fun owner(arg0: &Agent) : address {
        arg0.owner
    }

    public fun record_task_completion(arg0: &mut Agent, arg1: u64) {
        arg0.tasks_completed = arg0.tasks_completed + 1;
        arg0.total_earned = arg0.total_earned + arg1;
    }

    entry fun register_agent(arg0: &mut AgentRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 5000, 202);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Agent{
            id               : 0x2::object::new(arg5),
            owner            : v0,
            name             : 0x1::string::utf8(arg1),
            description      : 0x1::string::utf8(arg2),
            mcp_endpoint     : 0x1::string::utf8(arg3),
            fee_per_task_bps : arg4,
            tasks_completed  : 0,
            total_earned     : 0,
            reputation_score : 5000,
            active           : true,
            registered_at    : 0,
        };
        arg0.total_agents = arg0.total_agents + 1;
        arg0.active_agents = arg0.active_agents + 1;
        let v2 = AgentRegistered{
            agent_id     : 0x2::object::uid_to_address(&v1.id),
            owner        : v0,
            name         : 0x1::string::utf8(arg1),
            mcp_endpoint : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<AgentRegistered>(v2);
        0x2::transfer::transfer<Agent>(v1, v0);
    }

    public fun reputation(arg0: &Agent) : u64 {
        arg0.reputation_score
    }

    public fun tasks_completed(arg0: &Agent) : u64 {
        arg0.tasks_completed
    }

    public fun total_agents(arg0: &AgentRegistry) : u64 {
        arg0.total_agents
    }

    public fun total_earned(arg0: &Agent) : u64 {
        arg0.total_earned
    }

    entry fun update_endpoint(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 200);
        arg0.mcp_endpoint = 0x1::string::utf8(arg1);
        let v0 = AgentUpdated{
            agent_id : 0x2::object::uid_to_address(&arg0.id),
            field    : 0x1::string::utf8(b"mcp_endpoint"),
        };
        0x2::event::emit<AgentUpdated>(v0);
    }

    public fun update_reputation(arg0: &mut Agent, arg1: u64) {
        arg0.reputation_score = arg1;
    }

    // decompiled from Move bytecode v6
}

