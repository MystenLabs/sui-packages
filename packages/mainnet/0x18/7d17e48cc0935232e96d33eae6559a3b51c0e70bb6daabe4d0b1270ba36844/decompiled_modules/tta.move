module 0x187d17e48cc0935232e96d33eae6559a3b51c0e70bb6daabe4d0b1270ba36844::tta {
    struct TTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTA>(arg0, 6, b"TTA", b"Testing again", b"Test again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm3gzjlojq43vequ3if2uji25y3gjujqyl2coziruxwa4t2txw4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

