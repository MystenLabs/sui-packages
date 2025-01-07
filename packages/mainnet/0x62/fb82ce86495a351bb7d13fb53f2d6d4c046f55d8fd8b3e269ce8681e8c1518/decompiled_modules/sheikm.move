module 0x62fb82ce86495a351bb7d13fb53f2d6d4c046f55d8fd8b3e269ce8681e8c1518::sheikm {
    struct SHEIKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEIKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEIKM>(arg0, 6, b"SHEIKM", b"Sheik Marlon", x"4472792d686f7070696e67206475706c6f20636f6d0a43697472612c204d6f736169632c20526977616b612e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sheikmarlon_3d07f0df9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEIKM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEIKM>>(v1);
    }

    // decompiled from Move bytecode v6
}

