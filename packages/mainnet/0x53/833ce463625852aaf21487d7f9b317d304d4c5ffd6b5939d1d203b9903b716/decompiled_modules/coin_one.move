module 0x53833ce463625852aaf21487d7f9b317d304d4c5ffd6b5939d1d203b9903b716::coin_one {
    struct COIN_ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_ONE>(arg0, 9, b"coinone", b"coin one", b"the coin one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/3ef6ca18-084e-4888-93bc-f2f324aab128.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

