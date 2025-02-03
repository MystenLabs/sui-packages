module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue_set_authority_action {
    struct QueueAuthorityUpdated has copy, drop {
        queue_id: 0x2::object::ID,
        existing_authority: address,
        new_authority: address,
    }

    fun actuate(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: address) {
        let v0 = QueueAuthorityUpdated{
            queue_id           : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg0),
            existing_authority : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::authority(arg0),
            new_authority      : arg1,
        };
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::set_authority(arg0, arg1);
        0x2::event::emit<QueueAuthorityUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg2);
        actuate(arg0, arg1);
    }

    public fun validate(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::version(arg0) == 1, 9223372135639220228);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::has_authority(arg0, arg1), 9223372139934056450);
    }

    // decompiled from Move bytecode v6
}

