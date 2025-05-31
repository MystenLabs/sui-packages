module 0x9ab8131bedef02437768a98a9756c76d2d2aa4cc5687dc722d4ed956d142fbe7::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"WET", b"Wetcoin", x"546865206d6f697374206d656d650a0a52656c61756e6368696e67204c50206f6e20547572626f73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiggefyldk54yb54fbyqddxu3keqx5673dv2zamuk2yysfs7msjvgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

