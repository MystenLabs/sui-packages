module 0x95404085e8f30316ac917054e34ee28975279751164218b2acebff5b63e901e9::wag {
    struct WAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAG>(arg0, 6, b"WAG", b"SuiWag", x"54686520756c74696d617465206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e2c20636f6d62696e696e6720737761672c2066756e2c20616e6420636f6d6d756e6974792076696265732e205375695761672061696d7320746f206272696e6720225741474d492220656e6572677920746f20746865205375692065636f73797374656d2c2077697468206120746f6b656e2074686174277320617320626f6c6420616e64207374796c69736820617320697473206e616d652e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732178323588.12")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

