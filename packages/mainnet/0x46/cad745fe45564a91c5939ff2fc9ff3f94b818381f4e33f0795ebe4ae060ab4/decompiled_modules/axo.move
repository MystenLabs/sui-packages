module 0x46cad745fe45564a91c5939ff2fc9ff3f94b818381f4e33f0795ebe4ae060ab4::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"Axo", b"AxoOnSui", x"41786f207468652041786f6c6f746c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012490285.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

