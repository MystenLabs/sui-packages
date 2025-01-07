module 0xbbb91f2064703e67f7df29952fd1946cf4ae3978609dd8a3f7992cb68f3950d7::popnut {
    struct POPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPNUT>(arg0, 6, b"POPNUT", b"PopPeanut", b"$POPNUT forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953015719.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

