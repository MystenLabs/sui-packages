module 0x12c7f885179bb8ad21b3a1d872ae43235743026d8f4c8ba27c5c069981fdda5a::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"Suicide on Sui", b"Suicide Coin is a meme token on the SUI blockchain with a mission to spread positivity and raise mental health awareness. Featuring a cute tear drop character, this coin is all about embracing every emotion and building a supportive community on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xff7027af2a558ac3f78794241c700a9c14e4739c8a9820bbf4835f7769db41ea_suicide_suicide_4012290fad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

