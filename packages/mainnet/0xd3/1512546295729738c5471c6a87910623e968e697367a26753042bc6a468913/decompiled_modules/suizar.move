module 0xd31512546295729738c5471c6a87910623e968e697367a26753042bc6a468913::suizar {
    struct SUIZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZAR>(arg0, 6, b"SUIZAR", b"SUIZAR MEME", b"The ultimate rug-free meme on SUI. The SUIZAR is here to dominate all memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeighsteb4vgc7zxqmqtailfliwfdpw6q6mujikvdcpc37lwwy4kvrm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIZAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

