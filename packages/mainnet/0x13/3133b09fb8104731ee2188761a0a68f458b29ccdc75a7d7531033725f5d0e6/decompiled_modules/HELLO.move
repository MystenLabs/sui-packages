module 0x133133b09fb8104731ee2188761a0a68f458b29ccdc75a7d7531033725f5d0e6::HELLO {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"Hello", b"Hello it's me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmbDPLCBPt8WkQMDHvETdWqGf37r9GQtHxdNBYyVWzjFMP")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

