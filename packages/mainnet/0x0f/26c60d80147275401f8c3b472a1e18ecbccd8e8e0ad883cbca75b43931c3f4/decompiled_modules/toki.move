module 0xf26c60d80147275401f8c3b472a1e18ecbccd8e8e0ad883cbca75b43931c3f4::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 6, b"TOKI", b"toki", b"FWOG FANS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730976037209.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

