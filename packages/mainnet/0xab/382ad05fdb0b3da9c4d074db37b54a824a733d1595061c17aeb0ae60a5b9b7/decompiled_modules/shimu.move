module 0xab382ad05fdb0b3da9c4d074db37b54a824a733d1595061c17aeb0ae60a5b9b7::shimu {
    struct SHIMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIMU>(arg0, 6, b"Shimu", b"SHIMU", b"Shimu is a memecoin inspired by a character from the movie \"Kong: Skull Island.\" This memecoin focuses on entertainment and community, providing a fun experience for its users. With a unique theme and attractive design, Shimu aims to capture the attention of users in the cryptocurrency market. While it does not have complex utilitarian goals, Shimu becomes part of the evolving meme culture within the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fc92470cdf32267169ec666e00bdbdc0_46ad11b586.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

