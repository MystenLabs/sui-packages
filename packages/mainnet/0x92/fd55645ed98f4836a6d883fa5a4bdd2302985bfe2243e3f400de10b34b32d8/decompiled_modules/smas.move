module 0x92fd55645ed98f4836a6d883fa5a4bdd2302985bfe2243e3f400de10b34b32d8::smas {
    struct SMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAS>(arg0, 9, b"SMAS", b"Shibmas", b"The most wonderful Shibmas of the year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6D4B9eKsTbg5gW2DjYAZRyHKZVwM3BV2az5E4QWgpump.png?size=lg&key=419e06")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

