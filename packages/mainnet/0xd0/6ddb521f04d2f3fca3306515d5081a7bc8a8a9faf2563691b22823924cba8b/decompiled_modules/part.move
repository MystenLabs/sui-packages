module 0xd06ddb521f04d2f3fca3306515d5081a7bc8a8a9faf2563691b22823924cba8b::part {
    struct PART has drop {
        dummy_field: bool,
    }

    fun init(arg0: PART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PART>(arg0, 6, b"Part", b"Private part", b"I've had enough of the floor. I've lost almost everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240908_234502_fde633e93b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PART>>(v1);
    }

    // decompiled from Move bytecode v6
}

