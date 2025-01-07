module 0xd9ef7a329ecba80bfeec32ab5c88ebda49aba48a450f31bb2ab6dc7d7c4d029e::mod2 {
    public fun mint_first_from_mod1(arg0: &mut 0x2::tx_context::TxContext) {
        0xe44983fcb5063c4399ad17828ac84d75871a30d0cfa621d12b087458e6150aeb::mod1::make_first(arg0);
    }

    // decompiled from Move bytecode v6
}

