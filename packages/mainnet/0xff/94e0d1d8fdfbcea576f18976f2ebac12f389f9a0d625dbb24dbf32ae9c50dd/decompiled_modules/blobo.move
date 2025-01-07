module 0xff94e0d1d8fdfbcea576f18976f2ebac12f389f9a0d625dbb24dbf32ae9c50dd::blobo {
    struct BLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBO>(arg0, 6, b"BLOBO", b"Sui Blobo", b"\"Blobo\" refers to an exploitable MS Paint image of a blobfish frequently posted on 4chan and other forums with the sentence, \"BLOBO IS NEW MEME\". The image is often presented as a forced meme, similar to WOFL and Fefe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052136_579edded70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

