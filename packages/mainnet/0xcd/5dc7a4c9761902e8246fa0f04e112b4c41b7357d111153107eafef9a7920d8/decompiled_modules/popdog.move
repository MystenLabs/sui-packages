module 0xcd5dc7a4c9761902e8246fa0f04e112b4c41b7357d111153107eafef9a7920d8::popdog {
    struct POPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPDOG>(arg0, 6, 0x1::string::utf8(b"POPDOG"), 0x1::string::utf8(b"Popular Dog"), 0x1::string::utf8(b"the popular dog on sui"), 0x1::string::utf8(b"https://popularsui.xyz/media/e7855043b3a9499c376ec03b76a5888026cb22d4c14cc703eeca26a18f92d8bc.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPDOG>>(0x2::coin_registry::finalize<POPDOG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

