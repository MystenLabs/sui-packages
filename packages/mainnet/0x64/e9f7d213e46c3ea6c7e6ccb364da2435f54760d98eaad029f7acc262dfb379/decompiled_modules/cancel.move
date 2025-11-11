module 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::cancel {
    struct WishCancelled has copy, drop {
        wish_type: 0x1::type_name::TypeName,
    }

    public fun cancel_wish<T0: drop + store>(arg0: &mut 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::into_inner<T0>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::take_locked_update<0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        let v0 = WishCancelled{wish_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<WishCancelled>(v0);
    }

    // decompiled from Move bytecode v6
}

