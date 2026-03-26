module 0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::governance_intents {
    struct GovernanceWitness has copy, drop {
        dummy_field: bool,
    }

    struct GovernanceExecutionTicket {
        proposal_id: 0x2::object::ID,
    }

    public fun consume_governance_execution_ticket(arg0: GovernanceExecutionTicket, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::version_witness::VersionWitness, arg3: 0x2::object::ID) {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::version_witness::package_addr(&arg2);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::contains_package_addr(arg1, v0), 13);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::get_package_name(arg1, v0) == 0x1::string::utf8(b"FutarchyGovernance"), 13);
        let GovernanceExecutionTicket { proposal_id: v1 } = arg0;
        assert!(v1 == arg3, 14);
    }

    fun create_and_store_intent_from_spec(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: vector<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>, arg3: 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(!0x1::vector::is_empty<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(&arg2), 5);
        let v0 = 0x2::address::to_string(0x2::tx_context::fresh_object_address(arg6));
        let v1 = 0x2::clock::timestamp_ms(arg5) + arg4;
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0x2::clock::timestamp_ms(arg5));
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::create_intent<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, GovernanceWitness>(arg0, arg1, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_params(v0, 0x1::string::utf8(b"Just-in-time Proposal Execution"), v2, v1, arg5, arg6), arg3, 0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::futarchy_governance_actions_version::current(), witness(), arg6);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(&arg2)) {
            0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_existing_action_spec<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, GovernanceWitness>(&mut v3, *0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(&arg2, v4), witness());
            v4 = v4 + 1;
        };
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::stage_intent<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, GovernanceWitness>(arg0, arg1, v3, 0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::futarchy_governance_actions_version::current(), witness());
        0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::intent_janitor::register_intent<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(arg0, arg1, v0, v1, arg6);
        v0
    }

    public fun execute_proposal_intent<T0, T1>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::proposal_mutation_auth::ProposalMutationRegistry, arg3: &mut 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::Proposal<T0, T1>, arg4: u64, arg5: 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>, GovernanceExecutionTicket) {
        let v0 = 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::get_id<T0, T1>(arg3);
        assert!(0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::get_dao_id<T0, T1>(arg3) == 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0), 6);
        assert!(0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::get_state<T0, T1>(arg3) == 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::state_finalized(), 7);
        assert!(0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::is_winning_outcome_set<T0, T1>(arg3), 8);
        assert!(0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::get_winning_outcome<T0, T1>(arg3) == arg4, 9);
        let v1 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::outcome_proposal_id(&arg5);
        let v2 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::outcome_market_id(&arg5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1) && *0x1::option::borrow<0x2::object::ID>(&v1) == v0, 10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2) && *0x1::option::borrow<0x2::object::ID>(&v2) == 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::market_state_id<T0, T1>(arg3), 11);
        assert!(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::outcome_approved(&arg5), 12);
        let v3 = GovernanceWitness{dummy_field: false};
        let v4 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::proposal_mutation_auth::create<GovernanceWitness>(arg2, v3, 0x2::object::id<0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::Proposal<T0, T1>>(arg3));
        let v5 = 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::take_intent_spec_for_outcome<T0, T1>(arg3, arg4, &v4);
        assert!(0x1::option::is_some<vector<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>>(&v5), 4);
        0x1::option::destroy_none<vector<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>>(v5);
        let v6 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::proposal_intent_expiry_ms(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::governance_config(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::dao_config(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyConfig>(arg0))));
        let v7 = create_and_store_intent_from_spec(arg0, arg1, 0x1::option::extract<vector<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>>(&mut v5), arg5, v6, arg6, arg7);
        let (_, v9) = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::create_futarchy_executable(arg0, arg1, v7, 0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::futarchy_governance_actions_version::current(), arg6, arg7);
        let v10 = GovernanceExecutionTicket{proposal_id: v0};
        (v9, v10)
    }

    public(friend) fun witness() : GovernanceWitness {
        GovernanceWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

