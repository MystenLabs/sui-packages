module 0x5a73b9ee8a2c466517b802e9af86960019181397c56c6ad8675e8730f4ed6765::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"Siu", b"sui", b"Lowering the selling price", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734106063754.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

