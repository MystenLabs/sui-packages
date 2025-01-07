module 0xf3281c51289e3ab6c1ed9700e46c3bfe6c95bc2803013015e256eb7e443940e0::cpepe {
    struct CPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPEPE>(arg0, 6, b"CPEPE", b"Just a Chill PEPE", b"Just a chillin, Nothing else. It feels good, man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_18_53_18_53a68ae969.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

