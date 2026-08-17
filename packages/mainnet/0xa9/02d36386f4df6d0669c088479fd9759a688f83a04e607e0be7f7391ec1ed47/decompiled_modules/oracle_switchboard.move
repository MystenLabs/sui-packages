module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle_switchboard {
    struct SwitchboardBinding<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        aggregator_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        feed_id: 0x2::object::ID,
    }

    public fun binding_aggregator_id<T0, T1>(arg0: &SwitchboardBinding<T0, T1>) : 0x2::object::ID {
        arg0.aggregator_id
    }

    public fun binding_feed_id<T0, T1>(arg0: &SwitchboardBinding<T0, T1>) : 0x2::object::ID {
        arg0.feed_id
    }

    public fun create_binding<T0, T1>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::OracleAggregator<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        share_binding<T0, T1>(new_binding<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun new_binding<T0, T1>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::OracleAggregator<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) : SwitchboardBinding<T0, T1> {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T1>(arg1, arg2);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::assert_aggregator<T0, T1>(arg0, arg1, arg3);
        SwitchboardBinding<T0, T1>{
            id            : 0x2::object::new(arg6),
            aggregator_id : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::aggregator_id<T0, T1>(arg0),
            vault_id      : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T1>(arg1),
            feed_id       : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg5),
        }
    }

    public fun share_binding<T0, T1>(arg0: SwitchboardBinding<T0, T1>) {
        0x2::transfer::share_object<SwitchboardBinding<T0, T1>>(arg0);
    }

    public fun submit<T0, T1>(arg0: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::OracleAggregator<T0, T1>, arg1: &SwitchboardBinding<T0, T1>, arg2: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::Quorum, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg4: &0x2::clock::Clock) {
        assert!(arg1.aggregator_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::aggregator_id<T0, T1>(arg0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::oracle_mismatch());
        assert!(arg1.feed_id == 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg3), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::oracle_mismatch());
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg3);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::oracle_bad_param());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::push_sample<T0, T1>(arg0, arg2, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::source_switchboard(), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::normalize_decimals(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 18, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::oracle::quorum_scale(arg2)), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_timestamp_ms(v0), arg4);
    }

    public fun switchboard_decimals() : u8 {
        18
    }

    // decompiled from Move bytecode v7
}

