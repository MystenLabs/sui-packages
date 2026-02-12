module 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg1: &mut 0x2::tx_context::TxContext) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::wish_event::emit_cancel_wish_event<T0>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::into_inner<T0>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::take_locked_update<0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

