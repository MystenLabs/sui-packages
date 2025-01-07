module 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator_delete_action {
    struct AggregatorDeleted has copy, drop {
        aggregator_id: 0x2::object::ID,
    }

    fun actuate(arg0: 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) {
        let v0 = AggregatorDeleted{aggregator_id: 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::id(&arg0)};
        0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::delete(arg0);
        0x2::event::emit<AggregatorDeleted>(v0);
    }

    public entry fun run(arg0: 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        validate(&arg0, arg1);
        actuate(arg0);
    }

    public fun validate(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::version(arg0) == 1, 9223372114164383748);
        assert!(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::has_authority(arg0, arg1), 9223372118459219970);
    }

    // decompiled from Move bytecode v6
}

