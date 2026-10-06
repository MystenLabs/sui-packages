module 0xe05303a9ef081f3eb7d473dddab52373b3ed7e19590c61c175eab78dde3ea512::popcorn {
    struct POPCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPCORN>(arg0, 6, 0x1::string::utf8(b"POPCORN"), 0x1::string::utf8(b"POPCORN?"), 0x1::string::utf8(b"THIS POPCORN WAS PAIRED WITH POP FOR FUN! DEV HOLD 0"), 0x1::string::utf8(b"https://popularsui.xyz/media/093a6c312b54b08cd75ddc1adaf02c3587b64ae9d2472985da27aa506fee725d.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCORN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPCORN>>(0x2::coin_registry::finalize<POPCORN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

