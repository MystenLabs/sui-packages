module 0x49985a1a18afc95e03f5bcd7c5d704084aeb2d8aea32e3cf48455279edc9504::welion {
    struct WELION has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELION>(arg0, 9, b"WELION", b"LION", b"LION is a meme inspired by the spirit of adventure and freedom. With LION, we are not just riding the waves we are mastering them !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02bf60af-5682-4368-ac67-14ef859d1d50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WELION>>(v1);
    }

    // decompiled from Move bytecode v6
}

