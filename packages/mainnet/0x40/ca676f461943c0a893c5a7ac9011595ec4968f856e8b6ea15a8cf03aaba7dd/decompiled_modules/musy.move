module 0x40ca676f461943c0a893c5a7ac9011595ec4968f856e8b6ea15a8cf03aaba7dd::musy {
    struct MUSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSY>(arg0, 6, b"MUSY", b"musy", b"ihihih", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1772880716186.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

