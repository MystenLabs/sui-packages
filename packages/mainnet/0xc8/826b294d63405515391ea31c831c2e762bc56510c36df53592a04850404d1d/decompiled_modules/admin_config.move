module 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::admin_config {
    public fun set_active(arg0: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::permission::AdminCap, arg1: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::GlobalConfig) {
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::assert_version(arg1);
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::set_active_status(arg1, true);
    }

    public fun set_inactive(arg0: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::permission::AdminCap, arg1: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::GlobalConfig) {
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::assert_version(arg1);
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::set_active_status(arg1, false);
    }

    public fun set_package_version(arg0: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::permission::AdminCap, arg1: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::set_package_version(arg1, arg2, arg3);
    }

    public fun set_protocol_fee(arg0: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::permission::AdminCap, arg1: &mut 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::GlobalConfig, arg2: u64) {
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::assert_version(arg1);
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::set_protocol_fee(arg1, arg2);
    }

    public fun transfer_admin_role(arg0: &0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::GlobalConfig, arg1: 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::permission::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config::assert_version(arg0);
        0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::permission::transfer_admin_role(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

