module 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::initializer {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::admin::create_admin_cap(arg0);
    }

    // decompiled from Move bytecode v6
}

