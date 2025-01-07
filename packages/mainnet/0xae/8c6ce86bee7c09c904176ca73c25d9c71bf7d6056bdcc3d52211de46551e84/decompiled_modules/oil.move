module 0xae8c6ce86bee7c09c904176ca73c25d9c71bf7d6056bdcc3d52211de46551e84::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIL>(arg0, 6, b"OIL", b"SAND NIGGAS", b"Welcome to the Emirate of Sand Niggas. The Only Royalty That Matters! $OIL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_3r_M_Cge_400x400_18cb9a1f1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

