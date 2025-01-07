module 0x217ed0aea9edcc813653ebf806f98c16e5275662646d9bf2046fa2a1a85945b::lunc1000x {
    struct LUNC1000X has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNC1000X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNC1000X>(arg0, 6, b"LUNC1000x", b"LUNC", b"LUNC lasts forever. LUNC is a MEME coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Images_14_1024x536_1_38456b01e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNC1000X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNC1000X>>(v1);
    }

    // decompiled from Move bytecode v6
}

