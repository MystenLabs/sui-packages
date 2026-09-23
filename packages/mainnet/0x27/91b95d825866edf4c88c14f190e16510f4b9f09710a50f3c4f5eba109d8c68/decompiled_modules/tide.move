module 0x2791b95d825866edf4c88c14f190e16510f4b9f09710a50f3c4f5eba109d8c68::tide {
    struct TIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TIDE>(arg0, 6, 0x1::string::utf8(b"TIDE"), 0x1::string::utf8(b"High Tide"), 0x1::string::utf8(b"The ultimate momentum token. The meme centers on \"the tide rising for all ecosystem builders.\""), 0x1::string::utf8(b"https://popularsui.xyz/media/e6217be71d39a4e269bd8368fb6252938271ce6ab5163ceaf09e31a108f86695.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TIDE>>(0x2::coin_registry::finalize<TIDE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

