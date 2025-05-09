module 0xdc7236a49b08ce7082161402d9f9e8637ffd4d41133537fedd0730836637abf::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"SWOG", b"Swog Sui and Frog", b"To ensure a safe and fair launch, moonbags.io launchpad will be used for the launch, and liquidity will be added to cetus liquidity pool and be burnt once the token bonds (reaches 20k$ Market cap)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigidsvvbdqjqpz2apd3uo2t3msev7j6ijhn3rimtcvqdlavquk2hy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

