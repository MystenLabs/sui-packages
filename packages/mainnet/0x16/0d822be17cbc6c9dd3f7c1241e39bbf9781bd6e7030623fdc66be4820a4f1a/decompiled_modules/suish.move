module 0x160d822be17cbc6c9dd3f7c1241e39bbf9781bd6e7030623fdc66be4820a4f1a::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 9, b"SUISH", b"Sui Fishman", b"The Sui Fishman meme, known as SUISH, has gained popularity within the Sui blockchain community. The meme symbolizes community spirit and lightheartedness while also embracing the innovative aspects of the Sui blockchain.  Typically shared on social media and forums, SUISH serves as both an inside joke and a rallying symbol for Sui supporters, often highlighting the unique features and potential of the blockchain. The meme culture around SUISH fosters camaraderie and engagement among users, reflecting the fun and creative side of blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

