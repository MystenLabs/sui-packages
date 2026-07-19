module 0xd1a9a2046e42d289b9ee2c1cb27b1f1de0d1ea45746fe8740c215513652384b5::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"BlackSui", b"Black sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784470738887.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

