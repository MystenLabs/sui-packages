module 0xdd91c44cfe441cc05adf9dc623ee895bcc7b464bc66c0816235493e40b0d67c8::coin_one {
    struct COIN_ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_ONE>(arg0, 9, b"coinone", b"coin one", b"coin one desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/9892c684-293d-4bc8-b7b2-5c7b2f2c08b4.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

