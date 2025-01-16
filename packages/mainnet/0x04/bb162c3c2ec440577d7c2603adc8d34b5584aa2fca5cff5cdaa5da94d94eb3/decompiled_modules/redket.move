module 0x4bb162c3c2ec440577d7c2603adc8d34b5584aa2fca5cff5cdaa5da94d94eb3::redket {
    struct REDKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDKET>(arg0, 6, b"REDKET", b"RED KET", x"496d206a757374206120726564206361742074726164696e67206163726f73732074686520636861696e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737049158945.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDKET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDKET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

