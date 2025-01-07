module 0x89123f8fb77a595c8274be3c9dc9822ccd994f8810f95a83e7b1c81ef7b0c949::orcasui {
    struct ORCASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCASUI>(arg0, 6, b"ORCASUI", b"ORCA SUI DIAMOND", x"77652061726520746865206f72636120737569206469616d6f6e642068616e6420626f726e20696e202453554920626c6f636b636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22e28225_6760_4183_b8b5_19c8b4149eb1_19ad576aca_09e2f19d09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

