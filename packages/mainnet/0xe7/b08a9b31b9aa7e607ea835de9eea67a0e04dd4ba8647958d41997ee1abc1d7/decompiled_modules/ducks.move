module 0xe7b08a9b31b9aa7e607ea835de9eea67a0e04dd4ba8647958d41997ee1abc1d7::ducks {
    struct DUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKS>(arg0, 6, b"DUCKS", b"SUIDUCKIUS", b"Launch DEX > 24h", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/go_155816be1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

