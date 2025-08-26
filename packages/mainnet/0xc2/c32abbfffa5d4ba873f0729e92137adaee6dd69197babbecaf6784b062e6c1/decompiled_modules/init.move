module 0x1139e423b2ecefaf1fe80629f74a23f21e59f03d1618acfc4899adf0fac5ff1f::init {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x1139e423b2ecefaf1fe80629f74a23f21e59f03d1618acfc4899adf0fac5ff1f::dynamic_field::create_parent_and_share(arg0);
        0x1139e423b2ecefaf1fe80629f74a23f21e59f03d1618acfc4899adf0fac5ff1f::dynamic_object_field::create_parent_and_share(arg0);
    }

    // decompiled from Move bytecode v6
}

