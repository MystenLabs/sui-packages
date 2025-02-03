module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue_add_fee_coin_action {
    struct QueueFeeTypeAdded has copy, drop {
        queue_id: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
    }

    fun actuate<T0>(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue) {
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::add_fee_type<T0>(arg0);
        let v0 = QueueFeeTypeAdded{
            queue_id : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::id(arg0),
            fee_type : 0x1::type_name::get<0x2::coin::Coin<T0>>(),
        };
        0x2::event::emit<QueueFeeTypeAdded>(v0);
    }

    public entry fun run<T0>(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1);
        actuate<T0>(arg0);
    }

    public fun validate(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::version(arg0) == 1, 9223372139934187524);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::has_authority(arg0, arg1), 9223372144229023746);
    }

    // decompiled from Move bytecode v6
}

