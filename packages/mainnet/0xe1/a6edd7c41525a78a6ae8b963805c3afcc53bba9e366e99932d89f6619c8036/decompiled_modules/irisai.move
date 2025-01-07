module 0xe1a6edd7c41525a78a6ae8b963805c3afcc53bba9e366e99932d89f6619c8036::irisai {
    struct IRISAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRISAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRISAI>(arg0, 6, b"IRISAI", b"IRIS AI", b"Interactive Recursive Imagination System Gallery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731711384874.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRISAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRISAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

