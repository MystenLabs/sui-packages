module 0xdc042035ffe6d46365215eeaa9f8d77ef1e0e01b5a54b45d650ae2adac5d003b::tcn_mp40ezw9lr1n {
    struct TCN_MP40EZW9LR1N has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCN_MP40EZW9LR1N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCN_MP40EZW9LR1N>(arg0, 9, b"TCN", b"Tcoin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmfM6ALWU2nKjcPhbjdCTembXZ19Trj3YdFGAhBHYDGaAA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCN_MP40EZW9LR1N>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCN_MP40EZW9LR1N>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

