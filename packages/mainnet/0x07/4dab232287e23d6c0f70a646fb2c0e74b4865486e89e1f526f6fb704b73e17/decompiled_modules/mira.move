module 0x74dab232287e23d6c0f70a646fb2c0e74b4865486e89e1f526f6fb704b73e17::mira {
    struct MIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRA>(arg0, 9, b"MIRA", b"MIRAE", b"MIRAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1878681484829339648/doxj3rzy_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIRA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

