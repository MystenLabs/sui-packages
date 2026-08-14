module 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_cancel_wish_event<T0>(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::into_inner<T0>(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::take_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

