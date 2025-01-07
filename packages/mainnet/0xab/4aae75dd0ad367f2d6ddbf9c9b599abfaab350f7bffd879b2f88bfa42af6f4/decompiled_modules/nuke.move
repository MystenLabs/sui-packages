module 0xab4aae75dd0ad367f2d6ddbf9c9b599abfaab350f7bffd879b2f88bfa42af6f4::nuke {
    struct NUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKE>(arg0, 6, b"NUKE", b"Bitcoins to Bombs", b"Outcapping North Koreas stolen billions!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/china_2249d5148c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

