module 0x3c6646c5f16bb1eea14a0275c6e64384f6e7520e95ba4812d2ed55b167bf0763::irisai {
    struct IRISAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRISAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRISAI>(arg0, 6, b"IRISAI", b"IRIS AI", b"Interactive Recursive Imagination System Gallery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731631821759.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRISAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRISAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

