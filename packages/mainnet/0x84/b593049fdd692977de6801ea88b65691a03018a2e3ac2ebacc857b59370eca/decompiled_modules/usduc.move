module 0x84b593049fdd692977de6801ea88b65691a03018a2e3ac2ebacc857b59370eca::usduc {
    struct USDUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDUC>(arg0, 9, b"USDUC", b"unstable coin", b"unstable coin, u buy it before u go to sleep and don't know if'll be millionaire or hobo by the time u wake up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CB9dDufT3ZuQXqqSfa1c5kY935TEreyBw9XJXxHKpump.png?size=xl&key=155f12")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDUC>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDUC>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

