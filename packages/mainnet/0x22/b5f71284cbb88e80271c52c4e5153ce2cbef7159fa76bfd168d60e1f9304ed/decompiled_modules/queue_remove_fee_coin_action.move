module 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue_remove_fee_coin_action {
    struct QueueFeeTypeRemoved has copy, drop {
        queue_id: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
    }

    fun actuate<T0>(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue) {
        0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::remove_fee_type<T0>(arg0);
        let v0 = QueueFeeTypeRemoved{
            queue_id : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::id(arg0),
            fee_type : 0x1::type_name::get<0x2::coin::Coin<T0>>(),
        };
        0x2::event::emit<QueueFeeTypeRemoved>(v0);
    }

    public entry fun run<T0>(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1);
        actuate<T0>(arg0);
    }

    public fun validate(arg0: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::version(arg0) == 1, 9223372139934187524);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::has_authority(arg0, arg1), 9223372144229023746);
    }

    // decompiled from Move bytecode v6
}

