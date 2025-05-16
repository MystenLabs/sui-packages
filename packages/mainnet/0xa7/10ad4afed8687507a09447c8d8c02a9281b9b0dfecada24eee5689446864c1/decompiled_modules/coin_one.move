module 0xa710ad4afed8687507a09447c8d8c02a9281b9b0dfecada24eee5689446864c1::coin_one {
    struct COIN_ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_ONE>(arg0, 9, b"TICKERONE", b"coin one", b"description one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/2db7dffe-e8e9-4dc9-9229-12042e2b26e5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

