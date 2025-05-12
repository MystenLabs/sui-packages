module 0xf844ce700b9e0c7cbf3d83ac31eefbf8b94a8a7ef1c5e0f30da6535c06be1a61::quagsire {
    struct QUAGSIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAGSIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAGSIRE>(arg0, 6, b"Quagsire", b"Quagsire Sui", b"He might look retarded and cute, but beware Quagsire is here to safe sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidmg5kwrdn4cnseqkqhvtdx6lbabkkggcsimw37p76lrwbjef3lom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAGSIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUAGSIRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

