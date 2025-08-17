module 0xf45a528ea27f7ce464321acc3a67ac596b5ebff858fce35352fe48679b852b4e::ncn {
    struct NCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCN>(arg0, 6, b"NCN", b"NewCoin", b"Figuring out how to make a new coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeian2yln5bhqj7al4qrg7ieuencxdz2igm7b4d4irbmdlhczgl434q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NCN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

