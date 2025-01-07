module 0xba8c08686d33b02a49287e6c62fe2a678535cfac4010111ce09b0258703f6f0a::turnt {
    struct TURNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURNT>(arg0, 6, b"TURNT", b"Sui Turnt", b"$TURNT, the turtle addicted to speed. lets turn up on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinami_67c71b186d_3420015eb5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

