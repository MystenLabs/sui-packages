module 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::cancel {
    struct WishCancelled has copy, drop {
        wish_type: 0x1::type_name::TypeName,
    }

    public fun cancel_wish<T0: drop + store>(arg0: &mut 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::into_inner<T0>(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::take_locked_update<0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        let v0 = WishCancelled{wish_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<WishCancelled>(v0);
    }

    // decompiled from Move bytecode v6
}

