module 0xdf0375a5c475b5cfc509319d2e655b3a7bf709d424571cd0d2f4001cabd4384b::fuku {
    struct FUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKU>(arg0, 6, b"Fuku", b"Fuku.", b"where the power of a tsunami meets the playful spirit of a surf-loving Shiba Inu. This isn't just another token; it's a tidal wave of innovation on the Sui Blockchain. Surfing through the crypto market with unparalleled speed and agility, $fuku represents the force of nature in the world of digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022052_2118a5faec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

