module 0xc25aba12c90a548536daf46a5da2bd2be550987beed0d87abc1318fc0c04de9b::sugobs {
    struct SUGOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGOBS>(arg0, 6, b"Sugobs", b"SUIGOBLIN", b"Suigoblin is a mischievous meme token lurking in the shadows of the Sui Network. Fueled by chaos, cunning trades, and relentless community energy,  Suigoblin  is here to stir waves and snatch the spotlight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1745345321711_226234f80c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

