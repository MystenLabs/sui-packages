module 0x42b7e889b9affafb4a6b5a660c3625c1291cae1f5f8b7d644624a58f88bb3ab3::ldos {
    struct LDOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDOS>(arg0, 6, b"LDOS", b"LONG DOGS", x"4c6f6e6720446f6765204f532069732061206d656d65636f696e2d7374796c65206f7065726174696e672073797374656d2c206261636b656420616e642064726976656e20627920456c756e204d7572622c2061696d696e6720746f206265636f6d6520746865202331204f53206f6e20535549204e4554574f524b210a47657420726561647920666f7220746865206d6f737420646567656e2c20696e6e6f7661746976652c20616e64206d656d652d706f776572656420657870657269656e636520657665722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_69a5429a19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

