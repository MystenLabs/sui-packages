module 0xf8c6a607fdcdac835ccf5a571aa14824e83d752b34d7fe2b145e6b722c2cc421::aur {
    struct AUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUR>(arg0, 6, b"AUR", b"AURORA", b"AURORA is a cutting-edge decentralized token designed to drive innovation and community growth in the blockchain space. With a focus on scalability, security, and user empowerment, AURORA offers unique staking and governance features to reward its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUkhmhGtJxZTN9PWycZpBuTVEiScZquZvtUwEpNh7U3H4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AUR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

