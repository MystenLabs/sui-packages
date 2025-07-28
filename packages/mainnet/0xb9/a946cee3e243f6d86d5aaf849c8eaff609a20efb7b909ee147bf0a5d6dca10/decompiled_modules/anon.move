module 0xb9a946cee3e243f6d86d5aaf849c8eaff609a20efb7b909ee147bf0a5d6dca10::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"Anonymous", b"?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiftj3xnc3maortwepz46j4sa4soaoeyga7l7y2t2ybaubne5fscce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

