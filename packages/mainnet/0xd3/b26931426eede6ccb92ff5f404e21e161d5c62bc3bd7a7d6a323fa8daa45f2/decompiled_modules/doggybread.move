module 0xd3b26931426eede6ccb92ff5f404e21e161d5c62bc3bd7a7d6a323fa8daa45f2::doggybread {
    struct DOGGYBREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGYBREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGYBREAD>(arg0, 6, b"DOGGYBREAD", b"$DOGGYBREAD", b"Eat me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_21_18_25_41_c6b21720c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGYBREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGYBREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

