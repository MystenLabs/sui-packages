module 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::types {
    struct Capability has copy, drop, store {
        cap_type: u8,
        target: 0x1::option::Option<0x2::object::ID>,
        constraints: vector<u8>,
        delegatable: bool,
        expires_at: 0x1::option::Option<u64>,
    }

    struct TerminationCondition has copy, drop, store {
        condition_type: u8,
        value: u64,
        oracle_address: 0x1::option::Option<address>,
        task_description: vector<u8>,
        is_met: bool,
    }

    struct SpawnConfig has copy, drop, store {
        max_children: u64,
        spawn_cooldown: u64,
        required_stake_per_child: u64,
        budget_inheritance_rate: u16,
    }

    struct LifecycleConfig has copy, drop, store {
        max_lifespan: 0x1::option::Option<u64>,
        idle_timeout: 0x1::option::Option<u64>,
        termination_conditions: vector<TerminationCondition>,
    }

    public fun agent_status_active() : u8 {
        0
    }

    public fun agent_status_suspended() : u8 {
        1
    }

    public fun agent_status_terminated() : u8 {
        2
    }

    public fun cap_type_memory() : u8 {
        3
    }

    public fun cap_type_message() : u8 {
        2
    }

    public fun cap_type_sign() : u8 {
        0
    }

    public fun cap_type_spawn() : u8 {
        4
    }

    public fun cap_type_spend() : u8 {
        1
    }

    public fun capability_target(arg0: &Capability) : 0x1::option::Option<0x2::object::ID> {
        arg0.target
    }

    public fun capability_type(arg0: &Capability) : u8 {
        arg0.cap_type
    }

    public fun check_time_termination(arg0: &TerminationCondition, arg1: u64) : bool {
        if (arg0.condition_type != 0) {
            return false
        };
        arg1 >= arg0.value
    }

    public fun condition_type(arg0: &TerminationCondition) : u8 {
        arg0.condition_type
    }

    public fun default_max_lifespan() : u64 {
        604800
    }

    public fun default_spawn_cooldown() : u64 {
        3600
    }

    public fun is_agent_active(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_agent_suspended(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_agent_terminated(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_capability_expired(arg0: &Capability, arg1: u64) : bool {
        0x1::option::is_some<u64>(&arg0.expires_at) && arg1 >= *0x1::option::borrow<u64>(&arg0.expires_at)
    }

    public fun is_condition_met(arg0: &TerminationCondition) : bool {
        arg0.is_met
    }

    public fun is_delegatable(arg0: &Capability) : bool {
        arg0.delegatable
    }

    public fun lifecycle_idle_timeout(arg0: &LifecycleConfig) : 0x1::option::Option<u64> {
        arg0.idle_timeout
    }

    public fun lifecycle_max_lifespan(arg0: &LifecycleConfig) : 0x1::option::Option<u64> {
        arg0.max_lifespan
    }

    public fun lifecycle_termination_conditions(arg0: &LifecycleConfig) : &vector<TerminationCondition> {
        &arg0.termination_conditions
    }

    public fun mark_condition_met(arg0: &mut TerminationCondition) {
        arg0.is_met = true;
    }

    public fun max_inheritance_rate() : u16 {
        10000
    }

    public fun new_budget_termination(arg0: u64) : TerminationCondition {
        TerminationCondition{
            condition_type   : 1,
            value            : arg0,
            oracle_address   : 0x1::option::none<address>(),
            task_description : 0x1::vector::empty<u8>(),
            is_met           : false,
        }
    }

    public fun new_capability(arg0: u8, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<u8>, arg3: bool, arg4: 0x1::option::Option<u64>) : Capability {
        Capability{
            cap_type    : arg0,
            target      : arg1,
            constraints : arg2,
            delegatable : arg3,
            expires_at  : arg4,
        }
    }

    public fun new_lifecycle_config(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: vector<TerminationCondition>) : LifecycleConfig {
        LifecycleConfig{
            max_lifespan           : arg0,
            idle_timeout           : arg1,
            termination_conditions : arg2,
        }
    }

    public fun new_oracle_termination(arg0: address) : TerminationCondition {
        TerminationCondition{
            condition_type   : 3,
            value            : 0,
            oracle_address   : 0x1::option::some<address>(arg0),
            task_description : 0x1::vector::empty<u8>(),
            is_met           : false,
        }
    }

    public fun new_sign_capability(arg0: 0x1::option::Option<0x2::object::ID>, arg1: bool) : Capability {
        Capability{
            cap_type    : 0,
            target      : arg0,
            constraints : 0x1::vector::empty<u8>(),
            delegatable : arg1,
            expires_at  : 0x1::option::none<u64>(),
        }
    }

    public fun new_spawn_capability(arg0: u8, arg1: bool) : Capability {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        Capability{
            cap_type    : 4,
            target      : 0x1::option::none<0x2::object::ID>(),
            constraints : v0,
            delegatable : arg1,
            expires_at  : 0x1::option::none<u64>(),
        }
    }

    public fun new_spawn_config(arg0: u64, arg1: u64, arg2: u64, arg3: u16) : SpawnConfig {
        SpawnConfig{
            max_children             : arg0,
            spawn_cooldown           : arg1,
            required_stake_per_child : arg2,
            budget_inheritance_rate  : arg3,
        }
    }

    public fun new_spend_capability(arg0: u64, arg1: bool) : Capability {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        Capability{
            cap_type    : 1,
            target      : 0x1::option::none<0x2::object::ID>(),
            constraints : v0,
            delegatable : arg1,
            expires_at  : 0x1::option::none<u64>(),
        }
    }

    public fun new_task_termination(arg0: vector<u8>) : TerminationCondition {
        TerminationCondition{
            condition_type   : 2,
            value            : 0,
            oracle_address   : 0x1::option::none<address>(),
            task_description : arg0,
            is_met           : false,
        }
    }

    public fun new_time_termination(arg0: u64) : TerminationCondition {
        TerminationCondition{
            condition_type   : 0,
            value            : arg0,
            oracle_address   : 0x1::option::none<address>(),
            task_description : 0x1::vector::empty<u8>(),
            is_met           : false,
        }
    }

    public fun spawn_config_cooldown(arg0: &SpawnConfig) : u64 {
        arg0.spawn_cooldown
    }

    public fun spawn_config_inheritance_rate(arg0: &SpawnConfig) : u16 {
        arg0.budget_inheritance_rate
    }

    public fun spawn_config_max_children(arg0: &SpawnConfig) : u64 {
        arg0.max_children
    }

    public fun spawn_config_required_stake(arg0: &SpawnConfig) : u64 {
        arg0.required_stake_per_child
    }

    public fun term_condition_budget() : u8 {
        1
    }

    public fun term_condition_oracle() : u8 {
        3
    }

    public fun term_condition_task() : u8 {
        2
    }

    public fun term_condition_time() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

