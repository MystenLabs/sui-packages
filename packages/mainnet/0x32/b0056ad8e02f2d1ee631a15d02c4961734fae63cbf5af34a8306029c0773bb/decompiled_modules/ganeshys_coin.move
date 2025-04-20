module 0x32b0056ad8e02f2d1ee631a15d02c4961734fae63cbf5af34a8306029c0773bb::ganeshys_coin {
    struct GANESHYS_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANESHYS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANESHYS_COIN>(arg0, 8, b"ganeshys_coin", b"ganeshys_coin", b"This is my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/27858108?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANESHYS_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANESHYS_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

