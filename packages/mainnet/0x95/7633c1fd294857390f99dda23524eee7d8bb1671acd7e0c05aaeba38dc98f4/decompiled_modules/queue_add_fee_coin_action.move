module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue_add_fee_coin_action {
    struct QueueFeeTypeAdded has copy, drop {
        queue_id: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
    }

    fun actuate<T0>(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue) {
        0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::add_fee_type<T0>(arg0);
        let v0 = QueueFeeTypeAdded{
            queue_id : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::id(arg0),
            fee_type : 0x1::type_name::get<0x2::coin::Coin<T0>>(),
        };
        0x2::event::emit<QueueFeeTypeAdded>(v0);
    }

    public entry fun run<T0>(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1);
        actuate<T0>(arg0);
    }

    public fun validate(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::queue::has_authority(arg0, arg1), 9223372122754121729);
    }

    // decompiled from Move bytecode v6
}

