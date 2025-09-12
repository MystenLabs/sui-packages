module 0x6c29019db1d60f6689bf00a3492c2f05ef8f5383bc4bbda9b87f7045a469bf89::suizuki {
    struct SUIZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZUKI>(arg0, 6, b"SUIZUKI", b"SUI ZUKI", b"Sui Zuki - Fast blocks, low costs, limitless motion. Speedy, cheap and ready to move with blockchain hustle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigy5v4tbm77p6wto3gozgvakejxe2ugd7gwreiyypmm72oyeyfzqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIZUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

