module 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::admin_config {
    public fun set_active(arg0: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::permission::AdminCap, arg1: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::GlobalConfig) {
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::assert_version(arg1);
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::set_active_status(arg1, true);
    }

    public fun set_inactive(arg0: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::permission::AdminCap, arg1: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::GlobalConfig) {
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::assert_version(arg1);
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::set_active_status(arg1, false);
    }

    public fun set_package_version(arg0: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::permission::AdminCap, arg1: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee(arg0: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::permission::AdminCap, arg1: &mut 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::GlobalConfig, arg2: u64) {
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::assert_version(arg1);
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::set_protocol_fee(arg1, arg2);
    }

    public fun transfer_admin_role(arg0: &0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::GlobalConfig, arg1: 0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::global_config::assert_version(arg0);
        0xb8ce1468ba17650be57d5e1a0c515e8101fe172c8b0f3bce0be717947d1d58c0::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

