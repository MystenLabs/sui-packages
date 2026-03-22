module 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_cancel_wish_event<T0>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::into_inner<T0>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::take_locked_update<0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

