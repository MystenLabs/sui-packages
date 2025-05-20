module 0x5ae7d04b4d7fe3f0d453776449e2ffeed12c4d9a211e9e6362941418b3fbb811::zen {
    struct ZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEN>(arg0, 6, b"ZEN", b"ZENBOOK", b"FOR COMMUNTY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_01_02_37_44_4eb97d6c0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

