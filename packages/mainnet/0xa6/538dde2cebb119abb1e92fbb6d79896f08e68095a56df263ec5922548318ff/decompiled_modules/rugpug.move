module 0xa6538dde2cebb119abb1e92fbb6d79896f08e68095a56df263ec5922548318ff::rugpug {
    struct RUGPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPUG>(arg0, 6, b"RUGPUG", b"RUG IN A PUG", x"434f4d4520574f525348495020544845205055472120414c4c204841494c205448452050554720494e20412052554721200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_1a78af37da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

