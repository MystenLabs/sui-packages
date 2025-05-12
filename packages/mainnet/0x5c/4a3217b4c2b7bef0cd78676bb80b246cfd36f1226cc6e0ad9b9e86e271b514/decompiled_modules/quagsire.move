module 0x5c4a3217b4c2b7bef0cd78676bb80b246cfd36f1226cc6e0ad9b9e86e271b514::quagsire {
    struct QUAGSIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAGSIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAGSIRE>(arg0, 6, b"Quagsire", b"Quagsire SUI", b"He might look retarded and cute, but beware he is here to safe SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidmg5kwrdn4cnseqkqhvtdx6lbabkkggcsimw37p76lrwbjef3lom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAGSIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUAGSIRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

