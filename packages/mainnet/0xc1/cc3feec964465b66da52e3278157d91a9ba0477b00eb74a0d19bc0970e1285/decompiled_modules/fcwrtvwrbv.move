module 0xc1cc3feec964465b66da52e3278157d91a9ba0477b00eb74a0d19bc0970e1285::fcwrtvwrbv {
    struct FCWRTVWRBV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCWRTVWRBV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCWRTVWRBV>(arg0, 6, b"Fcwrtvwrbv", b"fcwrtvwrbv", b"IMSTRAUSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730866529143.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCWRTVWRBV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCWRTVWRBV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

