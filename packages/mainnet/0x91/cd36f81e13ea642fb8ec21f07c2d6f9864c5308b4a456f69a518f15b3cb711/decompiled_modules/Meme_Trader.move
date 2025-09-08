module 0x91cd36f81e13ea642fb8ec21f07c2d6f9864c5308b4a456f69a518f15b3cb711::Meme_Trader {
    struct MEME_TRADER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_TRADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_TRADER>(arg0, 9, b"TRADOOR", b"Meme Trader", b"Trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-fun.sgp1.cdn.digitaloceanspaces.com/TemporaryCoinAvatar/01K4KARX21RQJPVAAZVX4TBWMV.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_TRADER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_TRADER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

