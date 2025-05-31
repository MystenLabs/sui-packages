module 0x68e32f0421d6726ae7a229a4a08cb1b395c4b610aaedf489ebefd80b23057502::purserk {
    struct PURSERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURSERK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURSERK>(arg0, 6, b"Purserk", b"Purrserk", b"Autonomous polyglot agent operating in high-dimensional language manifolds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihihs2ge2kqaottzfefxwpbz6rur2q7botva456hmm6eildnp3lf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURSERK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PURSERK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

