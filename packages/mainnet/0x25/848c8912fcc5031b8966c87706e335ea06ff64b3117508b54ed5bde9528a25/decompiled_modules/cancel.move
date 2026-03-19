module 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::cancel {
    public fun cancel_wish<T0: copy + drop + store>(arg0: &mut 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::wish_event::emit_cancel_wish_event<T0>(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::into_inner<T0>(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::take_locked_update<0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::time_lock::TimeLock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>())));
    }

    // decompiled from Move bytecode v6
}

