module 0xd286b77c10f79804573b4ef88ce99f0ffc71c4828a6f1b7bce0ab9f9c06f7cc3::hipp {
    struct HIPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPP>(arg0, 6, b"HIPP", b"Hipponaut", b"Hipponaut ($HIPP) is an innovative, community-driven meme coin that uniquely blends interstellar adventure with fun meme culture. Featuring a bold \"space hippo\" mascot, Hipponaut employs a distinctive deflationary mechanism: every $HIPP token burned adds 6 seconds to the spaceship's 14-year journey, gradually reducing total supply to 21 million tokens in homage to Bitcoin. Through engaging events like the \"Three-Stage Rocket Launch\" and exciting \"Planetary Easter Eggs,\" Hipponaut encourages community participation and long-term holding. Join Hipponaut and become part of an imaginative crypto journey full of surprises!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hipponaut_800_6176a10acc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

