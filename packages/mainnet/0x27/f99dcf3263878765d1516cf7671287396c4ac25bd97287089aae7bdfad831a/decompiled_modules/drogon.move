module 0x27f99dcf3263878765d1516cf7671287396c4ac25bd97287089aae7bdfad831a::drogon {
    struct DROGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROGON>(arg0, 6, b"Drogon", b"$Drogon", b"has arrived to dominate the SUI blockchain with the power of a dragon! This meme token breathes fire into the crypto world, ready to fly high and bring massive gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_6e3f2639e5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

