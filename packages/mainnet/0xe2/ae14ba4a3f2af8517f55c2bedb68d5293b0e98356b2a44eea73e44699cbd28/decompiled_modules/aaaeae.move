module 0xe2ae14ba4a3f2af8517f55c2bedb68d5293b0e98356b2a44eea73e44699cbd28::aaaeae {
    struct AAAEAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAEAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAEAE>(arg0, 6, b"AAaeae", b"aeaea", b"eaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADA_3_6d91bea692.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAEAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAEAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

