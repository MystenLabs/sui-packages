module 0xbf235e2ff9fa04e18cd1ee8a19ec4bfb5796c851ee9e0fd1c39a3fa9ad8b0e7::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"King", x"4272657474322e30f09f92a3f09f92a3f09f92a3", x"5472757374207468652070726f63657373f09f9388", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734978470899.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

