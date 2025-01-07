module 0x720624701820614a6f9b9eb69b02d7d2d522246e8d37aabf328f28a924798d4a::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GIGA", b"ChadGPT", b"Chad GPT is not just a meme token. This is long-term project for everyone here. The ecosystem is much broader, and the main difference between Chad GPT and any other meme token is the Chad GPT dApp, which allows $GIGA holders to use dozens of different AI models for free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AM_Zj_Y_Cv4_400x400_715063a5a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

