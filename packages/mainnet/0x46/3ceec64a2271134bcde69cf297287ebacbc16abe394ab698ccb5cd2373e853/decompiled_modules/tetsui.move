module 0x463ceec64a2271134bcde69cf297287ebacbc16abe394ab698ccb5cd2373e853::tetsui {
    struct TETSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETSUI>(arg0, 6, b"TETSUI", b"Tetsui Akira", b"Tetsui : Good For Health", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiddwq25na2dmdjq6mpudngvtlbixegr4biqyf7u2iyxwufqkvb4le")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TETSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

