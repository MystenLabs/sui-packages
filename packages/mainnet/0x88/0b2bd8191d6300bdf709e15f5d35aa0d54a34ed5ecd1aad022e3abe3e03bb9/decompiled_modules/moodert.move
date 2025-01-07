module 0x880b2bd8191d6300bdf709e15f5d35aa0d54a34ed5ecd1aad022e3abe3e03bb9::moodert {
    struct MOODERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODERT>(arg0, 9, b"MOODERT", b"MOODERT", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOODERT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODERT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

