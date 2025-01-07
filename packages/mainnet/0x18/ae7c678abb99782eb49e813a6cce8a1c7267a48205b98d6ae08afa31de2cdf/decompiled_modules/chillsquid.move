module 0x18ae7c678abb99782eb49e813a6cce8a1c7267a48205b98d6ae08afa31de2cdf::chillsquid {
    struct CHILLSQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSQUID>(arg0, 9, b"CHILLSQUID", b"CHILL SQUID", b"Official token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.geckoterminal.com/gr2oqw7eqyb84dic5sf7nghls3oe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILLSQUID>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSQUID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

