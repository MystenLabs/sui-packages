module 0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::protective_bid_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CancelProtectiveBid<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct ProtectiveBidCancelledViaGovernance has copy, drop {
        bid_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        final_reserved_amount: u64,
        tokens_burned: u64,
    }

    struct CancelProtectiveBidAction has copy, drop, store {
        bid_id: 0x2::object::ID,
    }

    public fun add_cancel_protective_bid_spec<T0, T1>(arg0: &mut 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::Builder, arg1: 0x2::object::ID) {
        let v0 = CancelProtectiveBidAction{bid_id: arg1};
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::add(arg0, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<CancelProtectiveBid<T0, T1>>(), 0x2::bcs::to_bytes<CancelProtectiveBidAction>(&v0), 1));
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::new_builder();
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_id(&mut v1, b"bid_id", arg1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::emit_action_params(v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_type(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_id(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CancelProtectiveBid<T0, T1>>())), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::next_action_index(arg0));
    }

    public fun do_cancel_protective_bid<T0, T1, T2: store, T3: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T2>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: &0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &mut 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::ProtectiveBid<T0, T1>, arg5: T3) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T2>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T2>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T2>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<CancelProtectiveBid<T0, T1>>(v1);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::ProtectiveBid<T0, T1>>(arg4) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 2);
        assert!(0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::account_id<T0, T1>(arg4) == 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1), 2);
        0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::cancel<T0, T1>(arg4, arg1, arg2, 0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::liquidity_actions::new_spot_pool_mutation_auth(arg3, 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::pool_id<T0, T1>(arg4)));
        let v3 = ProtectiveBidCancelledViaGovernance{
            bid_id                : 0x2::object::id<0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::ProtectiveBid<T0, T1>>(arg4),
            account_id            : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            final_reserved_amount : 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::reserved_amount<T0, T1>(arg4),
            tokens_burned         : 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::protective_bid::base_bought_amount<T0, T1>(arg4),
        };
        0x2::event::emit<ProtectiveBidCancelledViaGovernance>(v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T2, CancelProtectiveBid<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v4);
    }

    // decompiled from Move bytecode v6
}

