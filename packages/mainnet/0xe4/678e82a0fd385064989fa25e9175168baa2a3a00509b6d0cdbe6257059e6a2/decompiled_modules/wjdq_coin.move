module 0xe4678e82a0fd385064989fa25e9175168baa2a3a00509b6d0cdbe6257059e6a2::wjdq_coin {
    struct WJDQ_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJDQ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJDQ_COIN>(arg0, 18, b"wjdq", b"wjdqCoin", b"this is wjdq coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/5901419")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WJDQ_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WJDQ_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

