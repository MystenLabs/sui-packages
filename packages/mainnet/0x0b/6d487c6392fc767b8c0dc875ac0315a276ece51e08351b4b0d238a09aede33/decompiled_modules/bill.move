module 0xb6d487c6392fc767b8c0dc875ac0315a276ece51e08351b4b0d238a09aede33::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 6, b"Bill", b"bill", b"bill me out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733574447488.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

