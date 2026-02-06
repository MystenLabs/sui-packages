module 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::genesis {
    struct AgentGenome has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        description: vector<u8>,
        base_capabilities: vector<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability>,
        max_spawn_depth: u8,
        spawn_config: 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::SpawnConfig,
        lifecycle_config: 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::LifecycleConfig,
        created_at: u64,
        updated_at: u64,
        total_spawned: u64,
        active_count: u64,
    }

    struct AgentInstance has store, key {
        id: 0x2::object::UID,
        genome_id: 0x2::object::ID,
        parent: 0x1::option::Option<0x2::object::ID>,
        children: vector<0x2::object::ID>,
        generation: u8,
        budget: 0x2::balance::Balance<0x2::sui::SUI>,
        capabilities: vector<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability>,
        spawned_at: u64,
        last_activity: u64,
        status: u8,
        kill_authorized: vector<address>,
        children_count: u64,
        last_spawn_at: u64,
    }

    struct GenomeAdminCap has store, key {
        id: 0x2::object::UID,
        genome_id: 0x2::object::ID,
    }

    struct AgentControlCap has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        agents: 0x2::table::Table<0x2::object::ID, address>,
        total_created: u64,
        active_count: u64,
    }

    public fun agent_budget(arg0: &AgentInstance) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.budget)
    }

    public fun agent_capabilities(arg0: &AgentInstance) : &vector<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability> {
        &arg0.capabilities
    }

    public fun agent_children(arg0: &AgentInstance) : &vector<0x2::object::ID> {
        &arg0.children
    }

    public fun agent_generation(arg0: &AgentInstance) : u8 {
        arg0.generation
    }

    public fun agent_last_activity(arg0: &AgentInstance) : u64 {
        arg0.last_activity
    }

    public fun agent_parent(arg0: &AgentInstance) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent
    }

    public fun agent_spawned_at(arg0: &AgentInstance) : u64 {
        arg0.spawned_at
    }

    public fun agent_status(arg0: &AgentInstance) : u8 {
        arg0.status
    }

    public fun create_genome(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability>, arg3: u8, arg4: 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::SpawnConfig, arg5: 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::LifecycleConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (AgentGenome, GenomeAdminCap) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = AgentGenome{
            id                : 0x2::object::new(arg7),
            creator           : v1,
            name              : arg0,
            description       : arg1,
            base_capabilities : arg2,
            max_spawn_depth   : arg3,
            spawn_config      : arg4,
            lifecycle_config  : arg5,
            created_at        : v0,
            updated_at        : v0,
            total_spawned     : 0,
            active_count      : 0,
        };
        let v3 = 0x2::object::id<AgentGenome>(&v2);
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_genome_created(v3, v1, arg3, 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::spawn_config_max_children(&arg4), v0);
        let v4 = GenomeAdminCap{
            id        : 0x2::object::new(arg7),
            genome_id : v3,
        };
        (v2, v4)
    }

    public fun genome_active_count(arg0: &AgentGenome) : u64 {
        arg0.active_count
    }

    public fun genome_total_spawned(arg0: &AgentGenome) : u64 {
        arg0.total_spawned
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentRegistry{
            id            : 0x2::object::new(arg0),
            agents        : 0x2::table::new<0x2::object::ID, address>(arg0),
            total_created : 0,
            active_count  : 0,
        };
        0x2::transfer::share_object<AgentRegistry>(v0);
    }

    public fun reclaim_child_budget(arg0: &mut AgentInstance, arg1: &AgentControlCap, arg2: &mut AgentInstance, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1.agent_id == 0x2::object::id<AgentInstance>(arg0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.parent) && *0x1::option::borrow<0x2::object::ID>(&arg2.parent) == 0x2::object::id<AgentInstance>(arg0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_parent());
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg2.budget), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::insufficient_funds());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.budget, 0x2::balance::split<0x2::sui::SUI>(&mut arg2.budget, arg3));
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_budget_reclaimed(0x2::object::id<AgentInstance>(arg2), 0x2::object::id<AgentInstance>(arg0), arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun record_activity(arg0: &mut AgentInstance, arg1: &AgentControlCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(arg1.agent_id == 0x2::object::id<AgentInstance>(arg0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        assert!(0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::is_agent_active(arg0.status), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::agent_not_active());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.last_activity = v0;
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_agent_activity(0x2::object::id<AgentInstance>(arg0), arg2, v0);
    }

    public fun registry_active_count(arg0: &AgentRegistry) : u64 {
        arg0.active_count
    }

    public fun registry_total_created(arg0: &AgentRegistry) : u64 {
        arg0.total_created
    }

    public fun resume_agent(arg0: &mut AgentInstance, arg1: &AgentControlCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.agent_id == 0x2::object::id<AgentInstance>(arg0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        assert!(0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::is_agent_suspended(arg0.status), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::invalid_status());
        arg0.status = 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::agent_status_active();
        arg0.last_activity = 0x2::clock::timestamp_ms(arg2);
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_agent_resumed(0x2::object::id<AgentInstance>(arg0), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public fun spawn_child_agent(arg0: &mut AgentGenome, arg1: &mut AgentRegistry, arg2: &mut AgentInstance, arg3: &AgentControlCap, arg4: u64, arg5: vector<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (AgentInstance, AgentControlCap) {
        assert!(arg3.agent_id == 0x2::object::id<AgentInstance>(arg2), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        assert!(0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::is_agent_active(arg2.status), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::agent_not_active());
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = &arg0.spawn_config;
        assert!(arg2.generation < arg0.max_spawn_depth, 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::spawn_depth_exceeded());
        assert!(arg2.children_count < 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::spawn_config_max_children(v1), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::max_children_reached());
        let v2 = 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::spawn_config_cooldown(v1);
        if (v2 > 0 && arg2.last_spawn_at > 0) {
            assert!(v0 >= arg2.last_spawn_at + v2 * 1000, 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::spawn_cooldown_active());
        };
        assert!(arg4 <= 0x2::balance::value<0x2::sui::SUI>(&arg2.budget) * (0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::spawn_config_inheritance_rate(v1) as u64) / 10000, 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::insufficient_funds());
        assert!(arg4 >= 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::spawn_config_required_stake(v1), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::insufficient_funds());
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability>(&arg5)) {
            assert!(0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::is_delegatable(0x1::vector::borrow<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::Capability>(&arg5, v3)), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::capability_not_delegatable());
            v3 = v3 + 1;
        };
        let v4 = arg2.kill_authorized;
        0x1::vector::push_back<address>(&mut v4, 0x2::tx_context::sender(arg7));
        let v5 = AgentInstance{
            id              : 0x2::object::new(arg7),
            genome_id       : 0x2::object::id<AgentGenome>(arg0),
            parent          : 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentInstance>(arg2)),
            children        : 0x1::vector::empty<0x2::object::ID>(),
            generation      : arg2.generation + 1,
            budget          : 0x2::balance::split<0x2::sui::SUI>(&mut arg2.budget, arg4),
            capabilities    : arg5,
            spawned_at      : v0,
            last_activity   : v0,
            status          : 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::agent_status_active(),
            kill_authorized : v4,
            children_count  : 0,
            last_spawn_at   : 0,
        };
        let v6 = 0x2::object::id<AgentInstance>(&v5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.children, v6);
        arg2.children_count = arg2.children_count + 1;
        arg2.last_spawn_at = v0;
        arg2.last_activity = v0;
        arg0.total_spawned = arg0.total_spawned + 1;
        arg0.active_count = arg0.active_count + 1;
        0x2::table::add<0x2::object::ID, address>(&mut arg1.agents, v6, 0x2::tx_context::sender(arg7));
        arg1.total_created = arg1.total_created + 1;
        arg1.active_count = arg1.active_count + 1;
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_agent_spawned(v6, 0x2::object::id<AgentGenome>(arg0), 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentInstance>(arg2)), v5.generation, arg4, v0);
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_budget_delegated(0x2::object::id<AgentInstance>(arg2), v6, arg4, v0);
        let v7 = AgentControlCap{
            id       : 0x2::object::new(arg7),
            agent_id : v6,
        };
        (v5, v7)
    }

    public fun spawn_root_agent(arg0: &mut AgentGenome, arg1: &mut AgentRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (AgentInstance, AgentControlCap) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::vector::empty<address>();
        let v3 = &mut v2;
        0x1::vector::push_back<address>(v3, v1);
        0x1::vector::push_back<address>(v3, arg0.creator);
        let v4 = AgentInstance{
            id              : 0x2::object::new(arg4),
            genome_id       : 0x2::object::id<AgentGenome>(arg0),
            parent          : 0x1::option::none<0x2::object::ID>(),
            children        : 0x1::vector::empty<0x2::object::ID>(),
            generation      : 0,
            budget          : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            capabilities    : arg0.base_capabilities,
            spawned_at      : v0,
            last_activity   : v0,
            status          : 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::agent_status_active(),
            kill_authorized : v2,
            children_count  : 0,
            last_spawn_at   : 0,
        };
        let v5 = 0x2::object::id<AgentInstance>(&v4);
        arg0.total_spawned = arg0.total_spawned + 1;
        arg0.active_count = arg0.active_count + 1;
        0x2::table::add<0x2::object::ID, address>(&mut arg1.agents, v5, v1);
        arg1.total_created = arg1.total_created + 1;
        arg1.active_count = arg1.active_count + 1;
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_agent_spawned(v5, 0x2::object::id<AgentGenome>(arg0), 0x1::option::none<0x2::object::ID>(), 0, 0x2::balance::value<0x2::sui::SUI>(&v4.budget), v0);
        let v6 = AgentControlCap{
            id       : 0x2::object::new(arg4),
            agent_id : v5,
        };
        (v4, v6)
    }

    public fun suspend_agent(arg0: &mut AgentInstance, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.kill_authorized, &v0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        assert!(0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::is_agent_active(arg0.status), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::agent_not_active());
        arg0.status = 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::agent_status_suspended();
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_agent_suspended(0x2::object::id<AgentInstance>(arg0), v0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun terminate_agent(arg0: &mut AgentGenome, arg1: &mut AgentRegistry, arg2: AgentInstance, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg2.kill_authorized, &v0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        assert!(!0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::is_agent_terminated(arg2.status), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::agent_terminated());
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg2.children), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::agent_has_children());
        let v1 = 0x2::object::id<AgentInstance>(&arg2);
        let AgentInstance {
            id              : v2,
            genome_id       : _,
            parent          : _,
            children        : _,
            generation      : _,
            budget          : v7,
            capabilities    : _,
            spawned_at      : _,
            last_activity   : _,
            status          : _,
            kill_authorized : _,
            children_count  : _,
            last_spawn_at   : _,
        } = arg2;
        0x2::object::delete(v2);
        arg0.active_count = arg0.active_count - 1;
        0x2::table::remove<0x2::object::ID, address>(&mut arg1.agents, v1);
        arg1.active_count = arg1.active_count - 1;
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_agent_terminated(v1, v0, arg3, 0x2::balance::value<0x2::sui::SUI>(&arg2.budget), 0x2::clock::timestamp_ms(arg4));
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg5)
    }

    public fun top_up_budget(arg0: &mut AgentInstance, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.budget, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_budget_topped_up(0x2::object::id<AgentInstance>(arg0), 0x2::coin::value<0x2::sui::SUI>(&arg1), 0x2::balance::value<0x2::sui::SUI>(&arg0.budget), 0x2::clock::timestamp_ms(arg2));
    }

    public fun update_genome(arg0: &mut AgentGenome, arg1: &GenomeAdminCap, arg2: 0x1::option::Option<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::SpawnConfig>, arg3: 0x1::option::Option<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::LifecycleConfig>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.genome_id == 0x2::object::id<AgentGenome>(arg0), 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors::not_authorized());
        if (0x1::option::is_some<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::SpawnConfig>(&arg2)) {
            arg0.spawn_config = 0x1::option::destroy_some<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::SpawnConfig>(arg2);
        };
        if (0x1::option::is_some<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::LifecycleConfig>(&arg3)) {
            arg0.lifecycle_config = 0x1::option::destroy_some<0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types::LifecycleConfig>(arg3);
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events::emit_genome_updated(0x2::object::id<AgentGenome>(arg0), 0x2::tx_context::sender(arg5), arg0.updated_at);
    }

    // decompiled from Move bytecode v6
}

