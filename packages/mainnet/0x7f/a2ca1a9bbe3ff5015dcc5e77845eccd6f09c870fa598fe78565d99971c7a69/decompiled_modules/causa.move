module 0x7fa2ca1a9bbe3ff5015dcc5e77845eccd6f09c870fa598fe78565d99971c7a69::causa {
    struct CAUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAUSA>(arg0, 6, b"CAUSA", b"Causa Pepe", x"52696465205375696e616d6920776974682055730a457820556e69746165205669726573202d20456e73204361757361205375690a546f676574686572205765205374726f6e672c20546f67657468657220576520436f6d706c656d656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6312159765752560409_6aaa73b54c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

