module 0xcc9a2642fa185847f48b212e7a4f5f831eec2312df33bccdba2b92da01e56f23::punpun {
    struct PUNPUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNPUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNPUN>(arg0, 6, b"PUNPUN", b"Punpun", b"Meet punpun panyama, he's an avarage kid in an avarage town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021612_01f0a7f2c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNPUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNPUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

