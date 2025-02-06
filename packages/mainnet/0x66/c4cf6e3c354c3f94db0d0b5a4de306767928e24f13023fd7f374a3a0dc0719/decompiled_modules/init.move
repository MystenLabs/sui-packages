module 0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::init {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::create_admin_cap(arg0);
    }

    // decompiled from Move bytecode v6
}

