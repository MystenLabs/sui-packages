module 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::governance_intents {
    struct GovernanceWitness has copy, drop {
        dummy_field: bool,
    }

    struct GovernanceExecutionTicket {
        proposal_id: 0x2::object::ID,
    }

    public fun consume_governance_execution_ticket(arg0: GovernanceExecutionTicket, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: 0x2::object::ID) {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(&arg3);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::contains_package_addr(arg1, v0), 13);
        assert!(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::is_authorized_package(arg2, v0), 13);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::get_package_name(arg1, v0) == 0x1::string::utf8(b"FutarchyGovernance"), 13);
        let GovernanceExecutionTicket { proposal_id: v1 } = arg0;
        assert!(v1 == arg4, 14);
    }

    fun create_and_store_intent_from_spec(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg3: 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(!0x1::vector::is_empty<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(&arg2), 5);
        let v0 = 0x2::address::to_string(0x2::tx_context::fresh_object_address(arg6));
        let v1 = 0x2::clock::timestamp_ms(arg5) + arg4;
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0x2::clock::timestamp_ms(arg5));
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_intent<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome, GovernanceWitness>(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_params(v0, 0x1::string::utf8(b"Just-in-time Proposal Execution"), v2, v1, arg5, arg6), arg3, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current(), witness(), arg6);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(&arg2)) {
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::add_existing_action_spec<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome, GovernanceWitness>(&mut v3, *0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(&arg2, v4), witness());
            v4 = v4 + 1;
        };
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::stage_intent<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome, GovernanceWitness>(arg0, arg1, v3, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current(), witness());
        0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::intent_janitor::register_intent<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome>(arg0, arg1, v0, v1, arg6);
        v0
    }

    public fun execute_proposal_intent<T0, T1>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg3: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg4: u64, arg5: 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome>, GovernanceExecutionTicket) {
        let v0 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg3);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg3) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 6);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg3) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_finalized(), 7);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_winning_outcome_set<T0, T1>(arg3), 8);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_winning_outcome<T0, T1>(arg3) == arg4, 9);
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::outcome_proposal_id(&arg5);
        let v2 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::outcome_market_id(&arg5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1) && *0x1::option::borrow<0x2::object::ID>(&v1) == v0, 10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2) && *0x1::option::borrow<0x2::object::ID>(&v2) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::market_state_id<T0, T1>(arg3), 11);
        assert!(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::outcome_approved(&arg5), 12);
        let v3 = GovernanceWitness{dummy_field: false};
        let v4 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<GovernanceWitness>(arg2, v3, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg3));
        let v5 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::take_intent_spec_for_outcome<T0, T1>(arg3, arg4, &v4);
        assert!(0x1::option::is_some<vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>>(&v5), 4);
        0x1::option::destroy_none<vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>>(v5);
        let v6 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::proposal_intent_expiry_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_config(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0))));
        let v7 = create_and_store_intent_from_spec(arg0, arg1, 0x1::option::extract<vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>>(&mut v5), arg5, v6, arg6, arg7);
        let (_, v9) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::create_futarchy_executable(arg0, arg1, v7, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current(), arg6, arg7);
        let v10 = GovernanceExecutionTicket{proposal_id: v0};
        (v9, v10)
    }

    public(friend) fun witness() : GovernanceWitness {
        GovernanceWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

