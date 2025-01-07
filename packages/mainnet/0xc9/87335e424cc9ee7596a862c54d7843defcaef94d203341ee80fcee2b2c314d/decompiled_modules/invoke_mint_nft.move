module 0xc987335e424cc9ee7596a862c54d7843defcaef94d203341ee80fcee2b2c314d::invoke_mint_nft {
    public entry fun call_mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc987335e424cc9ee7596a862c54d7843defcaef94d203341ee80fcee2b2c314d::my_hero::mint(0x1::string::utf8(arg0), 0x1::string::utf8(arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

