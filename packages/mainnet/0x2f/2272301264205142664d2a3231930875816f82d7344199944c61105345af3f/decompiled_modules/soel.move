module 0x2f2272301264205142664d2a3231930875816f82d7344199944c61105345af3f::soel {
    struct SOEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOEL>(arg0, 6, b"SOEL", b"SOEL SUI", b"Join the SOEL GANG  shill the coin, play the game, have fun, and stake your tokens! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_08_21_48_53_2b7746c3fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

