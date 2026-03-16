module 0x6432af42a13ca4959039643db01b481e48b8f53bc7659138407f296b088189a6::governance_intents {
    struct GovernanceWitness has copy, drop {
        dummy_field: bool,
    }

    struct GovernanceExecutionTicket {
        proposal_id: 0x2::object::ID,
    }

    public fun consume_governance_execution_ticket(arg0: GovernanceExecutionTicket, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::version_witness::VersionWitness, arg3: 0x2::object::ID) {
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::version_witness::package_addr(&arg2);
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::contains_package_addr(arg1, v0), 13);
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::get_package_name(arg1, v0) == 0x1::string::utf8(b"FutarchyGovernance"), 13);
        let GovernanceExecutionTicket { proposal_id: v1 } = arg0;
        assert!(v1 == arg3, 14);
    }

    fun create_and_store_intent_from_spec(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg3: 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(!0x1::vector::is_empty<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(&arg2), 5);
        let v0 = 0x2::address::to_string(0x2::tx_context::fresh_object_address(arg6));
        let v1 = 0x2::clock::timestamp_ms(arg5) + arg4;
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0x2::clock::timestamp_ms(arg5));
        let v3 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::create_intent<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome, GovernanceWitness>(arg0, arg1, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::new_params(v0, 0x1::string::utf8(b"Just-in-time Proposal Execution"), v2, v1, arg5, arg6), arg3, 0x6432af42a13ca4959039643db01b481e48b8f53bc7659138407f296b088189a6::futarchy_governance_actions_version::current(), witness(), arg6);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(&arg2)) {
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_existing_action_spec<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome, GovernanceWitness>(&mut v3, *0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(&arg2, v4), witness());
            v4 = v4 + 1;
        };
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::stage_intent<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome, GovernanceWitness>(arg0, arg1, v3, 0x6432af42a13ca4959039643db01b481e48b8f53bc7659138407f296b088189a6::futarchy_governance_actions_version::current(), witness());
        0x6432af42a13ca4959039643db01b481e48b8f53bc7659138407f296b088189a6::intent_janitor::register_intent<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome>(arg0, arg1, v0, v1, arg6);
        v0
    }

    public fun execute_proposal_intent<T0, T1>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::proposal_mutation_auth::ProposalMutationRegistry, arg3: &mut 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg4: u64, arg5: 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyOutcome>, GovernanceExecutionTicket) {
        let v0 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_id<T0, T1>(arg3);
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_dao_id<T0, T1>(arg3) == 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg0), 6);
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_state<T0, T1>(arg3) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::state_finalized(), 7);
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_winning_outcome_set<T0, T1>(arg3), 8);
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_winning_outcome<T0, T1>(arg3) == arg4, 9);
        let v1 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::outcome_proposal_id(&arg5);
        let v2 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::outcome_market_id(&arg5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1) && *0x1::option::borrow<0x2::object::ID>(&v1) == v0, 10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2) && *0x1::option::borrow<0x2::object::ID>(&v2) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::market_state_id<T0, T1>(arg3), 11);
        assert!(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::outcome_approved(&arg5), 12);
        let v3 = GovernanceWitness{dummy_field: false};
        let v4 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::proposal_mutation_auth::create<GovernanceWitness>(arg2, v3, 0x2::object::id<0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>>(arg3));
        let v5 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::take_intent_spec_for_outcome<T0, T1>(arg3, arg4, &v4);
        assert!(0x1::option::is_some<vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>>(&v5), 4);
        0x1::option::destroy_none<vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>>(v5);
        let v6 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::proposal_intent_expiry_ms(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::governance_config(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::dao_config(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyConfig>(arg0))));
        let v7 = create_and_store_intent_from_spec(arg0, arg1, 0x1::option::extract<vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>>(&mut v5), arg5, v6, arg6, arg7);
        let (_, v9) = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::create_futarchy_executable(arg0, arg1, v7, 0x6432af42a13ca4959039643db01b481e48b8f53bc7659138407f296b088189a6::futarchy_governance_actions_version::current(), arg6, arg7);
        let v10 = GovernanceExecutionTicket{proposal_id: v0};
        (v9, v10)
    }

    public(friend) fun witness() : GovernanceWitness {
        GovernanceWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

