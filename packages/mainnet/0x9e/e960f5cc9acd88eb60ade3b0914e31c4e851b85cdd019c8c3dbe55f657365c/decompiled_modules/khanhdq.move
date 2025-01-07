module 0x9ee960f5cc9acd88eb60ade3b0914e31c4e851b85cdd019c8c3dbe55f657365c::khanhdq {
    struct KHANHDQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHANHDQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHANHDQ>(arg0, 6, b"KHANHDQ", b"khanhdq", b"khanhdqq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732611591128.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHANHDQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHANHDQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

