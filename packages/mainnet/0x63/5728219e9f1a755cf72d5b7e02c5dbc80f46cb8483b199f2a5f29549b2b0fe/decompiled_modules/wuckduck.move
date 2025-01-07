module 0x635728219e9f1a755cf72d5b7e02c5dbc80f46cb8483b199f2a5f29549b2b0fe::wuckduck {
    struct WUCKDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUCKDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUCKDUCK>(arg0, 6, b"Wuckduck", b"Wuckduck On Sui", b"Wuckduck The Duck Sui Shines Bright", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_wuckduck_2e6273a41e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUCKDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUCKDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

