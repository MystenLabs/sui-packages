module 0xdbc1f8751848fb5b0ab043380ea97a84c38c39cc15d37911123a4a0bb4b3778a::riot_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        name: 0x1::string::String,
        role: 0x1::string::String,
        personality: 0x1::string::String,
        owner: address,
        memory_space_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        created_at: u64,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        total_agents: u64,
        admin: address,
    }

    struct Artifact has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        artifact_type: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        timestamp: u64,
        encrypted: bool,
    }

    struct AgentMinted has copy, drop {
        agent_id: 0x1::string::String,
        owner: address,
        memory_space_id: 0x1::string::String,
    }

    struct ArtifactStored has copy, drop {
        agent_id: 0x1::string::String,
        artifact_type: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        encrypted: bool,
    }

    struct MemoryUpdated has copy, drop {
        agent_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
    }

    public fun get_agent_info(arg0: &Agent) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, address) {
        (arg0.agent_id, arg0.name, arg0.role, arg0.memory_space_id, arg0.owner)
    }

    public fun get_artifact_info(arg0: &Artifact) : (0x1::string::String, 0x1::string::String, 0x1::string::String, bool) {
        (arg0.agent_id, arg0.artifact_type, arg0.walrus_blob_id, arg0.encrypted)
    }

    public fun get_registry_count(arg0: &AgentRegistry) : u64 {
        arg0.total_agents
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = AgentRegistry{
            id           : 0x2::object::new(arg0),
            total_agents : 0,
            admin        : v0,
        };
        0x2::transfer::share_object<AgentRegistry>(v2);
    }

    public entry fun mint_agent(arg0: &mut AgentRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = Agent{
            id              : 0x2::object::new(arg7),
            agent_id        : arg1,
            name            : arg2,
            role            : arg3,
            personality     : arg4,
            owner           : v0,
            memory_space_id : arg5,
            walrus_blob_id  : arg6,
            created_at      : 0x2::tx_context::epoch(arg7),
        };
        arg0.total_agents = arg0.total_agents + 1;
        let v2 = AgentMinted{
            agent_id        : v1.agent_id,
            owner           : v0,
            memory_space_id : v1.memory_space_id,
        };
        0x2::event::emit<AgentMinted>(v2);
        0x2::transfer::transfer<Agent>(v1, v0);
    }

    public entry fun store_artifact(arg0: &Agent, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Artifact{
            id             : 0x2::object::new(arg5),
            agent_id       : arg0.agent_id,
            artifact_type  : arg1,
            walrus_blob_id : arg2,
            metadata_uri   : arg3,
            timestamp      : 0x2::tx_context::epoch(arg5),
            encrypted      : arg4,
        };
        let v1 = ArtifactStored{
            agent_id       : arg0.agent_id,
            artifact_type  : v0.artifact_type,
            walrus_blob_id : v0.walrus_blob_id,
            encrypted      : arg4,
        };
        0x2::event::emit<ArtifactStored>(v1);
        0x2::transfer::transfer<Artifact>(v0, arg0.owner);
    }

    public entry fun update_agent_blob(arg0: &mut Agent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.walrus_blob_id = arg1;
    }

    public entry fun update_memory_space(arg0: &mut Agent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.memory_space_id = arg1;
    }

    // decompiled from Move bytecode v7
}

