module 0xa1c591a7fbfe7c3b82044c5e5860e160c7ae1692adfeaf2a2f37e405cefd845b::suiga {
    struct SUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGA>(arg0, 6, b"SUIGA", b"SUIGA CHAD", x"535549474120434841442d4120474947412043484144204f4e205448452053554920424c4f434b434841494e0a41534b20594f5553454c462e2e2e2041524520594f552047494741204d59205355494741204348414441524f4f534b493f200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giga_pfp_5c58e4d881.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

