module 0xa084363055ba764f2e3fda3222c05c1124907ad0a026aff3ec35feff34c74ac8::dacsa {
    struct DACSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACSA>(arg0, 6, b"Dacsa", b"dbav", b"vdabvda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731021880409.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DACSA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACSA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

