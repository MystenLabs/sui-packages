module 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::cancel {
    struct WishCancelled has copy, drop {
        wish_type: 0x1::type_name::TypeName,
    }

    public fun cancel_wish<T0: drop + store>(arg0: &mut 0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::into_inner<T0>(0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::governance::take_locked_update<0xac933c7a0879c984824e88ae8c2090bf5ee15440b39ff4fdb519f472f4ab914a::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        let v0 = WishCancelled{wish_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<WishCancelled>(v0);
    }

    // decompiled from Move bytecode v6
}

