module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue_set_configs_action {
    struct QueueConfigsUpdated has copy, drop {
        queue_id: 0x2::object::ID,
        name: 0x1::string::String,
        fee: u64,
        fee_recipient: address,
        min_attestations: u64,
        oracle_validity_length_ms: u64,
    }

    fun actuate(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::set_configs(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = QueueConfigsUpdated{
            queue_id                  : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg0),
            name                      : arg1,
            fee                       : arg2,
            fee_recipient             : arg3,
            min_attestations          : arg4,
            oracle_validity_length_ms : arg5,
        };
        0x2::event::emit<QueueConfigsUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg4, arg5, arg6);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun validate(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::version(arg0) == 1, 9223372178589155336);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::has_authority(arg0, arg3), 9223372182883729410);
        assert!(arg1 > 0, 9223372187178958854);
        assert!(arg2 > 0, 9223372191473795076);
    }

    // decompiled from Move bytecode v6
}

