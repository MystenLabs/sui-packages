module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_authority {
    struct LeaderPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        latch_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        leader_may_force_exit: bool,
        created_at_ms: u64,
    }

    struct ExitModeEntered has copy, drop {
        policy_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        verified_leader: address,
        entered_at_ms: u64,
    }

    public fun authorize_reallocation<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::HubState, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch, arg6: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg7: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg8: &vector<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route::ReallocationRouteLeg>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::AuthorizedHubCommand {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::assert_canonical_hub_and_registry(arg0, arg1, arg2);
        let (v0, _, _) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::validated_reallocation_route_for_accountings(arg6, arg7, arg8, arg3, arg9);
        let v3 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::authorize_validated_reallocation<T0>(arg0, arg1, arg2, arg3, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::issue_reallocation_witness(arg2, arg3, arg4, arg5, arg9, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg6), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg6), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_id(arg7), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::accounting_opportunity_id(arg7), arg12), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::start_reallocation<T0>(arg6, arg7, v0, arg9, arg12), arg10, arg11, arg12);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_activity_log::record_ordered(&v3, arg3, arg11, arg12);
        v3
    }

    public fun create_policy_and_latch(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg2: vector<u8>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert!(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap>(arg1) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::admin_cap_id(arg0), 1);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::leader_policy_anchored(arg0, arg2), 2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::strategy_id(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg0, arg2)) == arg2, 3);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::new_policy(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::id(arg0), arg2, arg3, arg5);
        let v1 = 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy>(&v0);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::new_latch(v1, arg5);
        let v3 = 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch>(&v2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::anchor_leader_policy(arg0, arg1, arg2, v1, v3, arg5);
        let v4 = LeaderPolicyCreated{
            policy_id             : v1,
            latch_id              : v3,
            registry_id           : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::id(arg0),
            strategy_id           : arg2,
            leader_may_force_exit : arg3,
            created_at_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LeaderPolicyCreated>(v4);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::freeze_policy(v0);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::share_latch(v2);
        (v1, v3)
    }

    public fun enter_exit_mode(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy, arg3: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::enter_latch(arg0, arg1, arg2, arg3, v0, arg5);
        let v1 = ExitModeEntered{
            policy_id       : 0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy>(arg2),
            strategy_id     : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_strategy_id(arg2),
            verified_leader : 0x2::tx_context::sender(arg5),
            entered_at_ms   : v0,
        };
        0x2::event::emit<ExitModeEntered>(v1);
    }

    public fun exit_mode_entered(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch) : bool {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::exit_mode_entered(arg0)
    }

    public fun exit_mode_entered_at_ms(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch) : u64 {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::exit_mode_entered_at_ms(arg0)
    }

    public fun latch_policy_id(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch) : 0x2::object::ID {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::latch_policy_id(arg0)
    }

    public fun leader_may_force_exit(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy) : bool {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::leader_may_force_exit(arg0)
    }

    public fun policy_id(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy) : 0x2::object::ID {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_id(arg0)
    }

    public fun policy_registry_id(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy) : 0x2::object::ID {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_registry_id(arg0)
    }

    public fun policy_strategy_id(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy) : vector<u8> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::policy_strategy_id(arg0)
    }

    // decompiled from Move bytecode v7
}

