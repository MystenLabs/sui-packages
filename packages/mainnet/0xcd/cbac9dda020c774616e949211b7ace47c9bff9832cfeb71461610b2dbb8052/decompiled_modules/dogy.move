module 0xcdcbac9dda020c774616e949211b7ace47c9bff9832cfeb71461610b2dbb8052::dogy {
    struct DOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGY>(arg0, 6, b"DOGY", b"Doggy", b"The Techy Meme Dog from the Future! DOGY is not just a meme, it is a movement. Half pupper, half machine, and 100% internet legend in the making", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicngmhybivfvpibmfspctlc6myuoxqpyb2wrk7ll7x2y4366pfttm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

