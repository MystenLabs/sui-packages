module 0x8fdc957f79bc40b2195856161f84f5568eb075b40464f2da11cf999f03149664::squidgame {
    struct SQUIDGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SQUIDGAME>(arg0, 6, b"SQUIDGAME", b"SQUID GAME ON SUIAI", b"The meme coin of SQUID GAME SEASON 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_e091af684b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIDGAME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDGAME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

