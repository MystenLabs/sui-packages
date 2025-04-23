module 0xe92df23751a387ee206e66561e1dc6a54670c3c05f538e41d8fdeff86692aa9a::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"DOPE", b"DOPEWARS GAME", b"Inspired by 90s classic, Dope Wars is an onchain strategy game. Flip product, out-hustle rivals & stack $DOPE to top the leaderboard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745385284810.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

