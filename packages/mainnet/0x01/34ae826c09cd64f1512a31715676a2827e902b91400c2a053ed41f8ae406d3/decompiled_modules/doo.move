module 0x134ae826c09cd64f1512a31715676a2827e902b91400c2a053ed41f8ae406d3::doo {
    struct DOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOO>(arg0, 6, b"DOO", b"Ducky Doo", b"Make Crypto Quack Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyxo6mir7bz3jdvbcbfo3if2zn7cc5562bic53drwhcaoc6qhqie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

