module 0x21ee3221d68eb637b03e35ba0748926dd3526b2f551d18ec72f1f6280ea87405::nobi {
    struct NOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBI>(arg0, 6, b"NOBI", b"Nobita", b"Nobitaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiclct5x6bua2khtmd2vbkgrbjluxnwbpph7vtcia62r4dsuqpxgk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

