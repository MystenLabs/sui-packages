module 0x30f4597850cf1f274aab62e3e9f3c0259c4850fc1e56ff5a003f698acf5034f1::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"Suibets", b"SUIBETS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_23_23_59_55_11f184632d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

