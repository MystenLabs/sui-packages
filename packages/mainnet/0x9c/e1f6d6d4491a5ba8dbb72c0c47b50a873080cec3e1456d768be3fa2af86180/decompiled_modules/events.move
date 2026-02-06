module 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::events {
    struct GenomeCreated has copy, drop {
        genome_id: 0x2::object::ID,
        creator: address,
        max_spawn_depth: u8,
        max_children: u64,
        created_at: u64,
    }

    struct GenomeUpdated has copy, drop {
        genome_id: 0x2::object::ID,
        updated_by: address,
        updated_at: u64,
    }

    struct AgentSpawned has copy, drop {
        agent_id: 0x2::object::ID,
        genome_id: 0x2::object::ID,
        parent_id: 0x1::option::Option<0x2::object::ID>,
        generation: u8,
        initial_budget: u64,
        spawned_at: u64,
    }

    struct AgentActivity has copy, drop {
        agent_id: 0x2::object::ID,
        activity_type: vector<u8>,
        activity_at: u64,
    }

    struct AgentSuspended has copy, drop {
        agent_id: 0x2::object::ID,
        suspended_by: address,
        reason: vector<u8>,
        suspended_at: u64,
    }

    struct AgentResumed has copy, drop {
        agent_id: 0x2::object::ID,
        resumed_by: address,
        resumed_at: u64,
    }

    struct AgentTerminated has copy, drop {
        agent_id: 0x2::object::ID,
        terminated_by: address,
        reason: vector<u8>,
        budget_reclaimed: u64,
        terminated_at: u64,
    }

    struct EmergencyKill has copy, drop {
        root_agent_id: 0x2::object::ID,
        killed_by: address,
        agents_terminated: u64,
        total_budget_reclaimed: u64,
        killed_at: u64,
    }

    struct CapabilityGranted has copy, drop {
        agent_id: 0x2::object::ID,
        cap_type: u8,
        target: 0x1::option::Option<0x2::object::ID>,
        delegatable: bool,
        granted_at: u64,
    }

    struct CapabilityRevoked has copy, drop {
        agent_id: 0x2::object::ID,
        cap_type: u8,
        revoked_by: address,
        revoked_at: u64,
    }

    struct CapabilityDelegated has copy, drop {
        from_agent_id: 0x2::object::ID,
        to_agent_id: 0x2::object::ID,
        cap_type: u8,
        delegated_at: u64,
    }

    struct BudgetDelegated has copy, drop {
        from_agent_id: 0x2::object::ID,
        to_agent_id: 0x2::object::ID,
        amount: u64,
        delegated_at: u64,
    }

    struct BudgetReclaimed has copy, drop {
        from_agent_id: 0x2::object::ID,
        to_agent_id: 0x2::object::ID,
        amount: u64,
        reclaimed_at: u64,
    }

    struct BudgetToppedUp has copy, drop {
        agent_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
        topped_up_at: u64,
    }

    struct IdleWarning has copy, drop {
        agent_id: 0x2::object::ID,
        last_activity: u64,
        idle_duration: u64,
        warning_at: u64,
    }

    struct LifespanWarning has copy, drop {
        agent_id: 0x2::object::ID,
        spawned_at: u64,
        max_lifespan: u64,
        remaining: u64,
        warning_at: u64,
    }

    struct TerminationConditionMet has copy, drop {
        agent_id: 0x2::object::ID,
        condition_type: u8,
        met_at: u64,
    }

    public fun emit_agent_activity(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = AgentActivity{
            agent_id      : arg0,
            activity_type : arg1,
            activity_at   : arg2,
        };
        0x2::event::emit<AgentActivity>(v0);
    }

    public fun emit_agent_resumed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = AgentResumed{
            agent_id   : arg0,
            resumed_by : arg1,
            resumed_at : arg2,
        };
        0x2::event::emit<AgentResumed>(v0);
    }

    public fun emit_agent_spawned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = AgentSpawned{
            agent_id       : arg0,
            genome_id      : arg1,
            parent_id      : arg2,
            generation     : arg3,
            initial_budget : arg4,
            spawned_at     : arg5,
        };
        0x2::event::emit<AgentSpawned>(v0);
    }

    public fun emit_agent_suspended(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = AgentSuspended{
            agent_id     : arg0,
            suspended_by : arg1,
            reason       : arg2,
            suspended_at : arg3,
        };
        0x2::event::emit<AgentSuspended>(v0);
    }

    public fun emit_agent_terminated(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64) {
        let v0 = AgentTerminated{
            agent_id         : arg0,
            terminated_by    : arg1,
            reason           : arg2,
            budget_reclaimed : arg3,
            terminated_at    : arg4,
        };
        0x2::event::emit<AgentTerminated>(v0);
    }

    public fun emit_budget_delegated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = BudgetDelegated{
            from_agent_id : arg0,
            to_agent_id   : arg1,
            amount        : arg2,
            delegated_at  : arg3,
        };
        0x2::event::emit<BudgetDelegated>(v0);
    }

    public fun emit_budget_reclaimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = BudgetReclaimed{
            from_agent_id : arg0,
            to_agent_id   : arg1,
            amount        : arg2,
            reclaimed_at  : arg3,
        };
        0x2::event::emit<BudgetReclaimed>(v0);
    }

    public fun emit_budget_topped_up(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = BudgetToppedUp{
            agent_id     : arg0,
            amount       : arg1,
            new_balance  : arg2,
            topped_up_at : arg3,
        };
        0x2::event::emit<BudgetToppedUp>(v0);
    }

    public fun emit_capability_delegated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        let v0 = CapabilityDelegated{
            from_agent_id : arg0,
            to_agent_id   : arg1,
            cap_type      : arg2,
            delegated_at  : arg3,
        };
        0x2::event::emit<CapabilityDelegated>(v0);
    }

    public fun emit_capability_granted(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool, arg4: u64) {
        let v0 = CapabilityGranted{
            agent_id    : arg0,
            cap_type    : arg1,
            target      : arg2,
            delegatable : arg3,
            granted_at  : arg4,
        };
        0x2::event::emit<CapabilityGranted>(v0);
    }

    public fun emit_capability_revoked(arg0: 0x2::object::ID, arg1: u8, arg2: address, arg3: u64) {
        let v0 = CapabilityRevoked{
            agent_id   : arg0,
            cap_type   : arg1,
            revoked_by : arg2,
            revoked_at : arg3,
        };
        0x2::event::emit<CapabilityRevoked>(v0);
    }

    public fun emit_emergency_kill(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = EmergencyKill{
            root_agent_id          : arg0,
            killed_by              : arg1,
            agents_terminated      : arg2,
            total_budget_reclaimed : arg3,
            killed_at              : arg4,
        };
        0x2::event::emit<EmergencyKill>(v0);
    }

    public fun emit_genome_created(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = GenomeCreated{
            genome_id       : arg0,
            creator         : arg1,
            max_spawn_depth : arg2,
            max_children    : arg3,
            created_at      : arg4,
        };
        0x2::event::emit<GenomeCreated>(v0);
    }

    public fun emit_genome_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = GenomeUpdated{
            genome_id  : arg0,
            updated_by : arg1,
            updated_at : arg2,
        };
        0x2::event::emit<GenomeUpdated>(v0);
    }

    public fun emit_idle_warning(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = IdleWarning{
            agent_id      : arg0,
            last_activity : arg1,
            idle_duration : arg2,
            warning_at    : arg3,
        };
        0x2::event::emit<IdleWarning>(v0);
    }

    public fun emit_lifespan_warning(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LifespanWarning{
            agent_id     : arg0,
            spawned_at   : arg1,
            max_lifespan : arg2,
            remaining    : arg3,
            warning_at   : arg4,
        };
        0x2::event::emit<LifespanWarning>(v0);
    }

    public fun emit_termination_condition_met(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = TerminationConditionMet{
            agent_id       : arg0,
            condition_type : arg1,
            met_at         : arg2,
        };
        0x2::event::emit<TerminationConditionMet>(v0);
    }

    // decompiled from Move bytecode v6
}

