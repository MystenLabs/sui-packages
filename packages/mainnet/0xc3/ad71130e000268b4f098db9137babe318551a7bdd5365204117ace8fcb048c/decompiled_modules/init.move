module 0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::init {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::create_admin_cap(arg0);
    }

    // decompiled from Move bytecode v6
}

