module 0x6e0ba61d953a0ff3b83516171c87106346f0700967870d140da0015df0ff890::suiiibscribe {
    struct SUIIIBSCRIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIBSCRIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIBSCRIBE>(arg0, 6, b"Suiiibscribe", b"UR Cristiano Parody", b"Welcome to UR Cristiano Parody - Let's reach the highest peak in the SUI World.. SUIIIBSCRIBE......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiibscribe_94c6a46026.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIBSCRIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIBSCRIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

