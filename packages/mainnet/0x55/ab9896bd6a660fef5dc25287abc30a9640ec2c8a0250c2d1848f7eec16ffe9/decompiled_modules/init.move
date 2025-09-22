module 0x55ab9896bd6a660fef5dc25287abc30a9640ec2c8a0250c2d1848f7eec16ffe9::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x55ab9896bd6a660fef5dc25287abc30a9640ec2c8a0250c2d1848f7eec16ffe9::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x55ab9896bd6a660fef5dc25287abc30a9640ec2c8a0250c2d1848f7eec16ffe9::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

