module 0x1501e16377a3a9ea1d7d8293d79e0a49c96992b17b953a946604523137cb2f60::wish {
    struct WISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISH>(arg0, 6, b"WISH", b"CatButt", b"Humanity's always had a special connection with the cat...but why? Ever notice how a feline behind will subltly find its way in your face? Be offended not. The mystical magical being is simply offering you an opp to make a wish upon its brown star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731368739879.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

