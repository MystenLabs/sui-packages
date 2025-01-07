module 0x2fc8c648cd858ff356f2a551c5735354277284f2e62273cc77aa4acfcac71ae5::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 6, b"ROCK", b"Rocky", b"Hold your ROCK, Strong ROCK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rocky_5990443419.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

