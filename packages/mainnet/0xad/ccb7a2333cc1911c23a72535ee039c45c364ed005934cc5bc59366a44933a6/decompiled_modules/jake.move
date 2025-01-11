module 0xadccb7a2333cc1911c23a72535ee039c45c364ed005934cc5bc59366a44933a6::jake {
    struct JAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKE>(arg0, 6, b"JAKE", b"Jake Awakening", b"Experience the spirit of competition with Jake, the meme coin that is here to be the newest contender in the Sui ecosystem. Supported by a strong community, Jake     aims to create a powerful momentum as the symbol of victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul42_20241226175425_2a4bf278d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

