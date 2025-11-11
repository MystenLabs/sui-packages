module 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::tipping {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::share_system(0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::create_system(arg0));
    }

    // decompiled from Move bytecode v6
}

