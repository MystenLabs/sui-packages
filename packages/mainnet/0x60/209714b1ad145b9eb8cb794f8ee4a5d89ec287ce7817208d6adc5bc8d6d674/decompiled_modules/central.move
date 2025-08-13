module 0x60209714b1ad145b9eb8cb794f8ee4a5d89ec287ce7817208d6adc5bc8d6d674::central {
    struct CENTRAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENTRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CENTRAL>(arg0, 6, b"CENTRAL", b"Centralized", x"54686520776f726c64e28099732066697273742063727970746f63757272656e6379207468617420676976657320796f75207a65726f20636f6e74726f6c20e2809420616e64207765206c696b652069742074686174207761792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Centralized_coin_logo_0e59c28818.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CENTRAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENTRAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

