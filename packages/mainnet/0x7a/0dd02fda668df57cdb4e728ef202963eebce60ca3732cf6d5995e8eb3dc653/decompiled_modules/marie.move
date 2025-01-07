module 0x7a0dd02fda668df57cdb4e728ef202963eebce60ca3732cf6d5995e8eb3dc653::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 6, b"Marie", b"Marie on Sui", b"Marie Rose Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_00_12_26_bad587dfa0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

