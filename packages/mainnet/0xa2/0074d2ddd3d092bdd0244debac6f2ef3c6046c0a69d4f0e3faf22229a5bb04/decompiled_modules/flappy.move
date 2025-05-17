module 0xa20074d2ddd3d092bdd0244debac6f2ef3c6046c0a69d4f0e3faf22229a5bb04::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAPPY>(arg0, 6, b"FLAPPY", b"FLAPPY SUI", b"$FLAPPY the Flying Penguin on SUIChain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaorx6ma4aoytsd32dnducyoo6lhueuhnqoott5isi4lc4h2ji3fi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLAPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

