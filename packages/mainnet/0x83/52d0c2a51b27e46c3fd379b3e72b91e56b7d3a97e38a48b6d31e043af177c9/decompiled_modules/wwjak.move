module 0x8352d0c2a51b27e46c3fd379b3e72b91e56b7d3a97e38a48b6d31e043af177c9::wwjak {
    struct WWJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWJAK>(arg0, 6, b"WWJAK", b"Water Wojak", b"Help! Glub, glub...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_13_163244_531f085a1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

