module 0xc4da974bc36c3696976969078ac28bba1f4e0e7b8439435539a4aa4a608dc1c4::qbit {
    struct QBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QBIT>(arg0, 6, b"QBIT", b"QubitCoin", b"Quantum computing meets crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidxwhvfrufp5txtcbvr7uwt2alfg6rsglc2bufqxgyulqgtjyuwrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QBIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

