module 0x7c2ba638053e42336b25145bfa3ca4d5ca2d405441c21b2ca464642ab0546bd5::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CAT>(arg0, 6, 0x1::string::utf8(b"CAT"), 0x1::string::utf8(b"POPCAT"), 0x1::string::utf8(b"FIRST POPCAT THAT PAIRED WITH OG POP."), 0x1::string::utf8(b"https://popularsui.xyz/media/21dfafaf4428549bc7b18c06191a5fa26e0749ccea732aede797ab4b43b34611.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CAT>>(0x2::coin_registry::finalize<CAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

