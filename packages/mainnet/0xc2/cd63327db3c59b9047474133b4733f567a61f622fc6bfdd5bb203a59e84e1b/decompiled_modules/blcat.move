module 0xc2cd63327db3c59b9047474133b4733f567a61f622fc6bfdd5bb203a59e84e1b::blcat {
    struct BLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLCAT>(arg0, 6, b"BLCAT", b"BLUECAT", b"I was looking for an extinct token - and I liked this logo and this name. Let's make a cool SUI MEME out of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihov2o2edxnvaw7qdl76htyfjn2vfi6serdnfcim37b3upjy6osvm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

