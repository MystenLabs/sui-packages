module 0xe4fffe9a93cd1eb78425c44537a07a6fad6bf1266e79d1f7e2b0f882420a23f4::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 6, b"Happy", b"Happyness", b"If You Want Something, Go Get It", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidyf6mw52emzjmh2zvpyb6xury3fyd7otwx4wzlc26ggwtrmby5lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

