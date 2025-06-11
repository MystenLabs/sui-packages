module 0xc6f6e6c5c5a3450e7add338c61b45b2c7550379e710c9d978e310eec8dfaecd7::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"Sui Brain", b"BRAIN is your cheeky, sarcastic genius on Sui Network, sharing all the thoughts you would not dare say out loud.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidjjtwy54kakc7kp5csvxgcl3dry5qkrujwpsmnz7bodm4s3kw3ta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

