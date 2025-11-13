module 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::cancel {
    struct WishCancelled has copy, drop {
        wish_type: 0x1::type_name::TypeName,
    }

    public fun cancel_wish<T0: drop + store>(arg0: &mut 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::into_inner<T0>(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::take_locked_update<0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()));
        let v0 = WishCancelled{wish_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<WishCancelled>(v0);
    }

    // decompiled from Move bytecode v6
}

