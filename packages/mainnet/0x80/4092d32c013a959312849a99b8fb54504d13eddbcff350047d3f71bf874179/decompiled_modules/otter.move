module 0x804092d32c013a959312849a99b8fb54504d13eddbcff350047d3f71bf874179::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"OTTER", b"OTTER SUI", b"The next million coin on SUI $OTTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3652_d3c9c8df39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

