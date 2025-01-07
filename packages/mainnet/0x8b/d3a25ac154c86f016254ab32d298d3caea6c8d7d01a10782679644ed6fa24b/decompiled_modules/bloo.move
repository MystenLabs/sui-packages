module 0x8bd3a25ac154c86f016254ab32d298d3caea6c8d7d01a10782679644ed6fa24b::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 6, b"Bloo", b"Sui Bloo", b"BLOO laughs, BLOO memes, BLOO profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_06_57_13_dad22cb1ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

