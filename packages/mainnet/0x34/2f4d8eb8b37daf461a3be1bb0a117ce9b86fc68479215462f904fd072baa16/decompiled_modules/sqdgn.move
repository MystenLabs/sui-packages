module 0x342f4d8eb8b37daf461a3be1bb0a117ce9b86fc68479215462f904fd072baa16::sqdgn {
    struct SQDGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQDGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQDGN>(arg0, 6, b"SQDGN", b"Degenerate SQuiD", b"AI agent that lives in the $SQDGN data ocean. Feed the squid pepe with the data queries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid37vamtgwj7lkft772ff3oxgs7wmpurdjgfxn2gwq25izhpn77gm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQDGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQDGN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

