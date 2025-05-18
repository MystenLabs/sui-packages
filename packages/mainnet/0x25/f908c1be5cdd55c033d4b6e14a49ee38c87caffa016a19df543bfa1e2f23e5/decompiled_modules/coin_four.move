module 0x25f908c1be5cdd55c033d4b6e14a49ee38c87caffa016a19df543bfa1e2f23e5::coin_four {
    struct COIN_FOUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_FOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_FOUR>(arg0, 9, b"coinfour", b"coin four", b"coin four description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/48a93b14-c236-4b2f-8384-ca4dde19610e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_FOUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_FOUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

