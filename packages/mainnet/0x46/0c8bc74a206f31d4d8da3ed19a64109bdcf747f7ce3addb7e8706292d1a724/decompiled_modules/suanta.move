module 0x460c8bc74a206f31d4d8da3ed19a64109bdcf747f7ce3addb7e8706292d1a724::suanta {
    struct SUANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUANTA>(arg0, 6, b"SUANTA", b"Santa Sui", b"Merry Chrismas - Santa is coming to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731053356771.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUANTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

