module 0x2d13f19c697d935113faeda5f1cee14e28f02092294b7748cbe55359e65b5d6a::trapp {
    struct TRAPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAPP>(arg0, 6, b"TRAPP", b"Trapp the Hippo", b"$TRAPP is a meme coin inspired by the legendary $HIPPO. Join the gang, the community of the people from the hood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiedq5hcyufjdweeaw6xakvpyymow4knkdmqs2t6hn3ibvx33gfebu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRAPP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

