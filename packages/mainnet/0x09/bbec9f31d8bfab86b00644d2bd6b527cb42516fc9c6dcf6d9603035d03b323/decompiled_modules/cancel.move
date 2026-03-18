module 0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg0);
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::wish_event::emit_cancel_wish_event<T0>(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::time_lock::into_inner<T0>(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::take_locked_update<0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

