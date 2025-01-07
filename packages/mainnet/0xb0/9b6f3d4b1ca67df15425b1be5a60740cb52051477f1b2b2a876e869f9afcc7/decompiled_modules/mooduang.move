module 0xb09b6f3d4b1ca67df15425b1be5a60740cb52051477f1b2b2a876e869f9afcc7::mooduang {
    struct MOODUANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODUANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODUANG>(arg0, 6, b"MooDuang", b"MooDuangC", b"$MOODUANG is the only real $MOODENG Cousin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/square_blended_photo_2024_10_07_76d2aac6fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODUANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODUANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

