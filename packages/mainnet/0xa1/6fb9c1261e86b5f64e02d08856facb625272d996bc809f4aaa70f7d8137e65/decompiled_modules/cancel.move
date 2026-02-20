module 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::wish_event::emit_cancel_wish_event<T0>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::into_inner<T0>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::take_locked_update<0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

