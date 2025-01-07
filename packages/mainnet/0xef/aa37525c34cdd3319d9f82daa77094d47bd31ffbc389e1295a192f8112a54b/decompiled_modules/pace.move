module 0xefaa37525c34cdd3319d9f82daa77094d47bd31ffbc389e1295a192f8112a54b::pace {
    struct PACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACE>(arg0, 6, b"PACE", b"Crypto Pace", b"Crypto Pace the best token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pace_be2c07f8a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

