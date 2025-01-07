module 0xdc42eeedd9c9149b89262f61c663e7c4a033da73be0a22b7de6eb680525d4d12::nabaronelon {
    struct NABARONELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NABARONELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NABARONELON>(arg0, 6, b"NABARONELON", b"Na-Baron Elon", b"Elon Al Gaib, now became the NA-Baron for Trump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nabaron_068e70b2bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NABARONELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NABARONELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

