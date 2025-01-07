module 0x910ae160081c11d048fac4640c9c946e98e70513804e2f05f8e54e2336baf41d::drogon {
    struct DROGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROGON>(arg0, 6, b"Drogon", b"$Drogon", b"has arrived to dominate the SUI blockchain with the power of a dragon! This meme token breathes fire into the crypto world, ready to fly high and bring massive gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_fbead06fba.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

