module 0xb3f37f206b5880d5a45f94cdc81d3b9ecd838e78afb48d6ac5ec95bf5309cec2::gbl {
    struct GBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBL>(arg0, 9, b"GBL", b"GOLDENBOOL", b"Bull Market Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a86e1261-280b-4db9-81ca-aeba805a3a38-1000019199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

