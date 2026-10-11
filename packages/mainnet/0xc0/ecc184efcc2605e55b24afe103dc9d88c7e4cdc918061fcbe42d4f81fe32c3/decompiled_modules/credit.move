module 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit {
    struct CREDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CREDIT>(arg0, 7, 0x1::string::utf8(b"CREDIT"), 0x1::string::utf8(b"CREDIT"), 0x1::string::utf8(b"CREDIT is the primary in-game currency for Cyberbrawl."), 0x1::string::utf8(b"https://static.cyberbrawl.io/credit_logo_512.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CREDIT>>(0x2::coin_registry::finalize<CREDIT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREDIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

