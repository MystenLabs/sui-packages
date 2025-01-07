module 0xc5f714472750964bb80c5a2c7dd1f6a646a533d35d0001acf392eebf3615cbfe::dogi {
    struct DOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGI>(arg0, 6, b"DOGI", b"Dogi", b"sui's first atari dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aid_75ee8352d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

