module 0xe3841247c627f06826379e031222b793104fefe9404ec4f95e078eeb35b30e8e::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL>(arg0, 9, b"SOL", b"solana", b"This is Solana token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSZb4DWpcQBjVeTWMKuhGMmqXyxZb4cL1U4xZardZoy2s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

