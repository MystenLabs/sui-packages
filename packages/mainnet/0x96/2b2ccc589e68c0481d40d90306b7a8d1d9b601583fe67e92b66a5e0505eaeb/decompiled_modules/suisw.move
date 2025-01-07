module 0x962b2ccc589e68c0481d40d90306b7a8d1d9b601583fe67e92b66a5e0505eaeb::suisw {
    struct SUISW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISW>(arg0, 6, b"SUISW", b"SuiSwine Coin", b"I have great ambitions, to reach for the moon, or beyond! Join me in this SuiSwine revolution - so we can pee og PEPE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_0aafc8ac91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISW>>(v1);
    }

    // decompiled from Move bytecode v6
}

