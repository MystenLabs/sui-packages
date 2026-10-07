module 0x9e1cccdc2fcbfd14aa8eaeed345b82fac73d2431285e9a5f129b7230092f0b4c::pox {
    struct POX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POX>(arg0, 6, 0x1::string::utf8(b"POX"), 0x1::string::utf8(b"POPXTAIL"), 0x1::string::utf8(b"POPXTAIL ESPORT IS A FIRST POPXTAIL THAT WILL REACH 1000x WHILE DEV HOLDING 0."), 0x1::string::utf8(b"https://popularsui.xyz/media/a208fffb1f0d234263ebdbb08c059f39150663c173d39b803fa1c67221c8c719.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POX>>(0x2::coin_registry::finalize<POX>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

