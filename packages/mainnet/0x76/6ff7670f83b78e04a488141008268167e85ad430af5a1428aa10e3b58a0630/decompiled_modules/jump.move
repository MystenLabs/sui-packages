module 0x766ff7670f83b78e04a488141008268167e85ad430af5a1428aa10e3b58a0630::jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 6, b"Jump", b"Sui jump", x"54686973206e6574776f726b206e656564732061206865726f202e2e2073757065726865726f0a0a496e74726f647563696e6720244a554d50", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029206_dcb1eb5102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

