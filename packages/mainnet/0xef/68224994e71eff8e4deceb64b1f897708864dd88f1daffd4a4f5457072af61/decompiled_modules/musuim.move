module 0xef68224994e71eff8e4deceb64b1f897708864dd88f1daffd4a4f5457072af61::musuim {
    struct MUSUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSUIM>(arg0, 6, b"MUSUIM", b"The Musuim", b"Admire unique artwork from the transactions of the $MUSUIM, Own meme history, on-chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnj2gtfj5wrj4l5bzgg2aqsuwkyvgb24z2qkran4zv6vv4ev7xzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUSUIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

