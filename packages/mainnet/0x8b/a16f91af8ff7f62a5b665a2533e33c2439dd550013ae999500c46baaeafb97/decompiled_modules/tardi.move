module 0x8ba16f91af8ff7f62a5b665a2533e33c2439dd550013ae999500c46baaeafb97::tardi {
    struct TARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDI>(arg0, 6, b"TARDI", b"Tardi Moon", b"Tardi the OG Moonboy / indestructible microscopic water bear.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigr2p4mw442jxbgxuu3a5wndor3b233zmh4p2ljt3y74ala2bgou4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARDI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

