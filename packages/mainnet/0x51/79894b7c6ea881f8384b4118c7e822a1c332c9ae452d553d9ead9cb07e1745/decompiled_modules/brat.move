module 0x5179894b7c6ea881f8384b4118c7e822a1c332c9ae452d553d9ead9cb07e1745::brat {
    struct BRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAT>(arg0, 6, b"BRAT", b"SUPER BRAT", b"SUPER BRAT is more than just a meme token, it's a community-driven cryptocurrency designed to bring fun and innovation to the Sui Chain. We aim to create a vibrant ecosystem where every holder can benefit from our unique approach to blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicm6odtsuwod3zqrftjlnxbsvb7e4isogpbdwfhfzopgvhqxiqzxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

