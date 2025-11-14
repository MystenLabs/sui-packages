module 0x3f9c866a39633461c0a7d93b1e7e469977ba1ad2a64ad241ad30936163f5ff30::cancel {
    struct WishCancelled has copy, drop {
        wish_type: 0x1::type_name::TypeName,
    }

    public fun cancel_wish<T0: drop + store>(arg0: &mut 0x3f9c866a39633461c0a7d93b1e7e469977ba1ad2a64ad241ad30936163f5ff30::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0x3f9c866a39633461c0a7d93b1e7e469977ba1ad2a64ad241ad30936163f5ff30::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x3f9c866a39633461c0a7d93b1e7e469977ba1ad2a64ad241ad30936163f5ff30::time_lock::into_inner<T0>(0x3f9c866a39633461c0a7d93b1e7e469977ba1ad2a64ad241ad30936163f5ff30::governance::take_locked_update<0x3f9c866a39633461c0a7d93b1e7e469977ba1ad2a64ad241ad30936163f5ff30::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        let v0 = WishCancelled{wish_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<WishCancelled>(v0);
    }

    // decompiled from Move bytecode v6
}

