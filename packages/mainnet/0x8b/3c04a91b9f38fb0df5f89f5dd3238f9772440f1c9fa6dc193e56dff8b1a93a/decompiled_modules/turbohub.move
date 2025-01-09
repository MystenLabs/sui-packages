module 0x8b3c04a91b9f38fb0df5f89f5dd3238f9772440f1c9fa6dc193e56dff8b1a93a::turbohub {
    struct TURBOHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOHUB>(arg0, 6, b"TURBOHUB", b"TURBO HUB", b"THE BEST NOPOR VIDEOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736459736783.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOHUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOHUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

