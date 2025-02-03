module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue_remove_fee_coin_action {
    struct QueueFeeTypeRemoved has copy, drop {
        queue_id: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
    }

    fun actuate<T0>(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue) {
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::remove_fee_type<T0>(arg0);
        let v0 = QueueFeeTypeRemoved{
            queue_id : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::id(arg0),
            fee_type : 0x1::type_name::get<0x2::coin::Coin<T0>>(),
        };
        0x2::event::emit<QueueFeeTypeRemoved>(v0);
    }

    public entry fun run<T0>(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1);
        actuate<T0>(arg0);
    }

    public fun validate(arg0: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::has_authority(arg0, arg1), 9223372122754121729);
    }

    // decompiled from Move bytecode v6
}

