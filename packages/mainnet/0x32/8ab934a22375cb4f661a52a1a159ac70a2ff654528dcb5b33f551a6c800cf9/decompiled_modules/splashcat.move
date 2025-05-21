module 0x328ab934a22375cb4f661a52a1a159ac70a2ff654528dcb5b33f551a6c800cf9::splashcat {
    struct SPLASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHCAT>(arg0, 9, b"SPLASHCAT", b"Splash Cat", b"SPLASHCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ink/0x20c69c12abf2b6f8d8ca33604dd25c700c7e70a5.png?size=xl&key=fa92d6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPLASHCAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHCAT>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

