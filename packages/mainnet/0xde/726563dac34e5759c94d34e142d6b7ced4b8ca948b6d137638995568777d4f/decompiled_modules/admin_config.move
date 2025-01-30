module 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::admin_config {
    public fun set_active(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::set_active_status(arg1, true);
    }

    public fun set_inactive(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::set_active_status(arg1, false);
    }

    public fun set_package_version(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: u64) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::set_protocol_fee(arg1, arg2);
    }

    public fun transfer_admin_role(arg0: &0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg1: 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg0);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

