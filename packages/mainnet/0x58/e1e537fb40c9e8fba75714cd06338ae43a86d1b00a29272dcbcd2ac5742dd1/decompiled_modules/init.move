module 0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::init {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::create_admin_cap(arg0);
    }

    // decompiled from Move bytecode v6
}

