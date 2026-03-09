module 0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_functional(arg0);
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::wish_event::emit_cancel_wish_event<T0>(0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::time_lock::into_inner<T0>(0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::take_locked_update<0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

