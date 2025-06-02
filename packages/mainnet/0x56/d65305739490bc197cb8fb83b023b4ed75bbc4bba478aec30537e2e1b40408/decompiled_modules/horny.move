module 0x56d65305739490bc197cb8fb83b023b4ed75bbc4bba478aec30537e2e1b40408::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"HORNY", b"Horny The Goat", b"HORNY is the token turning heads and wagging tails in crypto. Powered by number go up energy and the charisma of the horniest GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidej2k2m2fxaix2dvg65dycavgv3aiuztm64ojmaad3uiunxjc6au")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

