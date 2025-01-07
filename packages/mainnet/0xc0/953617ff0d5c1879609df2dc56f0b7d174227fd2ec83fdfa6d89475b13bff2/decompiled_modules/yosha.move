module 0xc0953617ff0d5c1879609df2dc56f0b7d174227fd2ec83fdfa6d89475b13bff2::yosha {
    struct YOSHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOSHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOSHA>(arg0, 6, b"YOSHA", b"Yosoku Sha", x"546865204669727374204d656d65636f696e20506f77657265640a427920582b436f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001699_1621ae7ff5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOSHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOSHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

