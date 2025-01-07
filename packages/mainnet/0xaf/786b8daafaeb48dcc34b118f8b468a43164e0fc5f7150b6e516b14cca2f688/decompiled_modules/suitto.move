module 0xaf786b8daafaeb48dcc34b118f8b468a43164e0fc5f7150b6e516b14cca2f688::suitto {
    struct SUITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTO>(arg0, 6, b"SUITTO", b"Suitto", b"Suitto will transform Sui. Morph into the trend and beat jeeters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_b15cea1417.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

