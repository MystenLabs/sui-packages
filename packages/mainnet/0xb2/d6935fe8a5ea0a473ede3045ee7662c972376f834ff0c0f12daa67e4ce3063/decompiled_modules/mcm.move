module 0xb2d6935fe8a5ea0a473ede3045ee7662c972376f834ff0c0f12daa67e4ce3063::mcm {
    struct MCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCM>(arg0, 6, b"MCM", b"MEME COIN MILLIONAIRE", b"It's a lifestyle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5055_dea600d3ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

