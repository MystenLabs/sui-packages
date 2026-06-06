module 0x64bea6270d379cb1e9e75bab769fa671d2421f072572f82e807dee6e94c604d4::agent_registry {
    struct AgentRegistry has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
        latest_version_id: 0x1::option::Option<0x2::object::ID>,
        version_count: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct AgentVersion has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        version_number: u64,
        parent_version_id: 0x1::option::Option<0x2::object::ID>,
        walrus_config_blob_id: 0x1::string::String,
        walrus_snapshot_blob_id: 0x1::option::Option<0x1::string::String>,
        commit_message: 0x1::string::String,
        created_at: u64,
    }

    struct AgentExecution has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        walrus_log_blob_id: 0x1::string::String,
        duration_ms: u64,
        success: bool,
        created_at: u64,
    }

    struct AgentCreated has copy, drop {
        agent_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
    }

    struct VersionCreated has copy, drop {
        version_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        version_number: u64,
        walrus_config_blob_id: 0x1::string::String,
    }

    struct ExecutionLogged has copy, drop {
        execution_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        walrus_log_blob_id: 0x1::string::String,
        success: bool,
    }

    struct AgentForked has copy, drop {
        new_agent_id: 0x2::object::ID,
        source_version_id: 0x2::object::ID,
        owner: address,
    }

    public fun agent_name(arg0: &AgentRegistry) : &0x1::string::String {
        &arg0.name
    }

    public fun agent_owner(arg0: &AgentRegistry) : address {
        arg0.owner
    }

    public fun agent_version_count(arg0: &AgentRegistry) : u64 {
        arg0.version_count
    }

    entry fun create_agent(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = AgentRegistry{
            id                : 0x2::object::new(arg5),
            name              : arg0,
            description       : arg1,
            owner             : v1,
            latest_version_id : 0x1::option::none<0x2::object::ID>(),
            version_count     : 0,
            created_at        : v0,
            updated_at        : v0,
        };
        let v3 = 0x2::object::id<AgentRegistry>(&v2);
        let v4 = AgentVersion{
            id                      : 0x2::object::new(arg5),
            agent_id                : v3,
            version_number          : 1,
            parent_version_id       : 0x1::option::none<0x2::object::ID>(),
            walrus_config_blob_id   : arg2,
            walrus_snapshot_blob_id : 0x1::option::none<0x1::string::String>(),
            commit_message          : arg3,
            created_at              : v0,
        };
        let v5 = 0x2::object::id<AgentVersion>(&v4);
        v2.latest_version_id = 0x1::option::some<0x2::object::ID>(v5);
        v2.version_count = 1;
        let v6 = AgentCreated{
            agent_id : v3,
            name     : v2.name,
            owner    : v1,
        };
        0x2::event::emit<AgentCreated>(v6);
        let v7 = VersionCreated{
            version_id            : v5,
            agent_id              : v3,
            version_number        : 1,
            walrus_config_blob_id : v4.walrus_config_blob_id,
        };
        0x2::event::emit<VersionCreated>(v7);
        0x2::transfer::transfer<AgentRegistry>(v2, v1);
        0x2::transfer::transfer<AgentVersion>(v4, v1);
    }

    entry fun create_version(arg0: &mut AgentRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<AgentRegistry>(arg0);
        let v2 = arg0.version_count + 1;
        let v3 = AgentVersion{
            id                      : 0x2::object::new(arg4),
            agent_id                : v1,
            version_number          : v2,
            parent_version_id       : arg0.latest_version_id,
            walrus_config_blob_id   : arg1,
            walrus_snapshot_blob_id : 0x1::option::none<0x1::string::String>(),
            commit_message          : arg2,
            created_at              : v0,
        };
        let v4 = 0x2::object::id<AgentVersion>(&v3);
        arg0.latest_version_id = 0x1::option::some<0x2::object::ID>(v4);
        arg0.version_count = v2;
        arg0.updated_at = v0;
        let v5 = VersionCreated{
            version_id            : v4,
            agent_id              : v1,
            version_number        : v2,
            walrus_config_blob_id : v3.walrus_config_blob_id,
        };
        0x2::event::emit<VersionCreated>(v5);
        0x2::transfer::transfer<AgentVersion>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun execution_duration(arg0: &AgentExecution) : u64 {
        arg0.duration_ms
    }

    public fun execution_success(arg0: &AgentExecution) : bool {
        arg0.success
    }

    entry fun fork_agent(arg0: &AgentVersion, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::object::id<AgentVersion>(arg0);
        let v3 = AgentRegistry{
            id                : 0x2::object::new(arg6),
            name              : arg1,
            description       : arg2,
            owner             : v1,
            latest_version_id : 0x1::option::none<0x2::object::ID>(),
            version_count     : 0,
            created_at        : v0,
            updated_at        : v0,
        };
        let v4 = 0x2::object::id<AgentRegistry>(&v3);
        let v5 = AgentVersion{
            id                      : 0x2::object::new(arg6),
            agent_id                : v4,
            version_number          : 1,
            parent_version_id       : 0x1::option::some<0x2::object::ID>(v2),
            walrus_config_blob_id   : arg3,
            walrus_snapshot_blob_id : 0x1::option::none<0x1::string::String>(),
            commit_message          : arg4,
            created_at              : v0,
        };
        let v6 = 0x2::object::id<AgentVersion>(&v5);
        v3.latest_version_id = 0x1::option::some<0x2::object::ID>(v6);
        v3.version_count = 1;
        let v7 = AgentForked{
            new_agent_id      : v4,
            source_version_id : v2,
            owner             : v1,
        };
        0x2::event::emit<AgentForked>(v7);
        let v8 = VersionCreated{
            version_id            : v6,
            agent_id              : v4,
            version_number        : 1,
            walrus_config_blob_id : v5.walrus_config_blob_id,
        };
        0x2::event::emit<VersionCreated>(v8);
        0x2::transfer::transfer<AgentRegistry>(v3, v1);
        0x2::transfer::transfer<AgentVersion>(v5, v1);
    }

    entry fun log_execution(arg0: &AgentRegistry, arg1: &AgentVersion, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<AgentRegistry>(arg0);
        let v1 = 0x2::object::id<AgentVersion>(arg1);
        let v2 = AgentExecution{
            id                 : 0x2::object::new(arg6),
            agent_id           : v0,
            version_id         : v1,
            walrus_log_blob_id : arg2,
            duration_ms        : arg3,
            success            : arg4,
            created_at         : 0x2::clock::timestamp_ms(arg5),
        };
        let v3 = ExecutionLogged{
            execution_id       : 0x2::object::id<AgentExecution>(&v2),
            agent_id           : v0,
            version_id         : v1,
            walrus_log_blob_id : v2.walrus_log_blob_id,
            success            : arg4,
        };
        0x2::event::emit<ExecutionLogged>(v3);
        0x2::transfer::transfer<AgentExecution>(v2, 0x2::tx_context::sender(arg6));
    }

    public fun version_blob_id(arg0: &AgentVersion) : &0x1::string::String {
        &arg0.walrus_config_blob_id
    }

    public fun version_number(arg0: &AgentVersion) : u64 {
        arg0.version_number
    }

    // decompiled from Move bytecode v7
}

