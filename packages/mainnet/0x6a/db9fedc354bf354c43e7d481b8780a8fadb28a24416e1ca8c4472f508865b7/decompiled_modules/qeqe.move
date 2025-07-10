module 0x6adb9fedc354bf354c43e7d481b8780a8fadb28a24416e1ca8c4472f508865b7::qeqe {
    struct QEQE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QEQE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QEQE>(arg0, 6, b"Qeqe", b"$qeqe", x"4e657720657261200a4e65772070726f6a656374200a4e6577207374796c65200a4e657720425443", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752174230661.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QEQE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QEQE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

