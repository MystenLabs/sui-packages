module 0xebda0a4ca2d806aa88780d334ec1c943942c224dfc2e7daa32be3fe9c3f442bf::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 6, b"FF", b"fff", b"f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

