module 0x25b034ccc8972703ae4f2a22c18c0b627903b1eb2916d09a6a0bd2edf639b949::axolt {
    struct AXOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOLT>(arg0, 6, b"AXOLT", b"Axolotl", b"Vision meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022061_99c1a2eabc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

