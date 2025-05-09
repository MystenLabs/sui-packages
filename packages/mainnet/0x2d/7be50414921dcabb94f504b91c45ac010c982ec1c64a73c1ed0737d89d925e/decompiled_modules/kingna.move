module 0x2d7be50414921dcabb94f504b91c45ac010c982ec1c64a73c1ed0737d89d925e::kingna {
    struct KINGNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGNA>(arg0, 6, b"Kingna", b"Kingna The King of Shit", b"Kingna the King of Shit. He rule them all! All memes will bow down to His Golden Toilet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzn6bkfd3qcyzaatgcsi3ofy67vvex3mxn74zi3pm65sjll4mcfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGNA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

