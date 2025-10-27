module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator_set_configs_action {
    struct AggregatorConfigsUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        feed_hash: vector<u8>,
        min_sample_size: u64,
        max_staleness_seconds: u64,
        max_variance: u64,
        min_responses: u32,
    }

    fun actuate(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u32) {
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::set_configs(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = AggregatorConfigsUpdated{
            aggregator_id         : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg0),
            feed_hash             : arg1,
            min_sample_size       : arg2,
            max_staleness_seconds : arg3,
            max_variance          : arg4,
            min_responses         : arg5,
        };
        0x2::event::emit<AggregatorConfigsUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun validate(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::version(arg0) == 1, 13906834350437892110);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::has_authority(arg0, arg6), 13906834354732072962);
        assert!(arg2 > 0, 13906834359027171332);
        assert!(arg4 > 0, 13906834363322269702);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834367617368072);
        assert!(arg5 > 0, 13906834371912466442);
        assert!(arg3 > 0, 13906834376207564812);
    }

    // decompiled from Move bytecode v6
}

