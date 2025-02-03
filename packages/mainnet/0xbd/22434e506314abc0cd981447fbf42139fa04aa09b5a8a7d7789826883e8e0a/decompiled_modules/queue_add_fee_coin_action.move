module 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue_add_fee_coin_action {
    struct QueueFeeTypeAdded has copy, drop {
        queue_id: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
    }

    fun actuate<T0>(arg0: &mut 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::Queue) {
        0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::add_fee_type<T0>(arg0);
        let v0 = QueueFeeTypeAdded{
            queue_id : 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::id(arg0),
            fee_type : 0x1::type_name::get<0x2::coin::Coin<T0>>(),
        };
        0x2::event::emit<QueueFeeTypeAdded>(v0);
    }

    public entry fun run<T0>(arg0: &mut 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1);
        actuate<T0>(arg0);
    }

    public fun validate(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::Queue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::version(arg0) == 1, 9223372139934187524);
        assert!(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::queue::has_authority(arg0, arg1), 9223372144229023746);
    }

    // decompiled from Move bytecode v6
}

