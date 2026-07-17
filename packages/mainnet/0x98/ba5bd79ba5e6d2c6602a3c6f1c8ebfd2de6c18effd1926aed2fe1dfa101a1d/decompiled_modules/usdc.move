module 0x98ba5bd79ba5e6d2c6602a3c6f1c8ebfd2de6c18effd1926aed2fe1dfa101a1d::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<USDC>(arg0, 6, b"USDC", b"USD Coin", x"55534420436f696e2028436972636c652920e2809420737461626c65636f696e2070656767656420746f205553442e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.circle.com/usdc")), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDC>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v2);
    }

    // decompiled from Move bytecode v7
}

