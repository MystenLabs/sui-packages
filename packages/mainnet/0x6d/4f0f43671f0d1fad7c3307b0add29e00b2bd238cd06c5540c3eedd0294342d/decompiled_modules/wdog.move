module 0x6d4f0f43671f0d1fad7c3307b0add29e00b2bd238cd06c5540c3eedd0294342d::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 9, b"wDOG", b"wDOG", b"WrappedDog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GYKmdfcUmZVrqfcH1g579BGjuzSRijj3LBuwv79rpump.png?size=lg&key=558dc6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WDOG>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

