module 0x968cc7ba6426e1c47858ab7714d8b49c17df3df44bccb67fcb10485a49db46d9::suinotes {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x968cc7ba6426e1c47858ab7714d8b49c17df3df44bccb67fcb10485a49db46d9::fund::create_fund(arg0);
    }

    // decompiled from Move bytecode v6
}

