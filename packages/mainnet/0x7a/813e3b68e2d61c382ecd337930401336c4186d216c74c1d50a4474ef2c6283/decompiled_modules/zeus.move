module 0x7a813e3b68e2d61c382ecd337930401336c4186d216c74c1d50a4474ef2c6283::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 6, b"Zeus", b"SuiZeus", b"Sui Zeus Pepe's Dog is a meme coin built on the high-speed Sui blockchain, drawing inspiration from Pepe the Frog and the mythological Zeus. This token blends humor, legend, and community spirit, offering a unique crypto experience. Join the community, hold the power, and aim for greatness with $Zeus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzlrb6cf77lkiftjngdev2xemmo3ntvswwxl37h4pjfqjjnnjcee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

