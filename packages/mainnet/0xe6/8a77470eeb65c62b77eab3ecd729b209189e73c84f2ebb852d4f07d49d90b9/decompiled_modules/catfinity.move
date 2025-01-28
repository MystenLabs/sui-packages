module 0xe68a77470eeb65c62b77eab3ecd729b209189e73c84f2ebb852d4f07d49d90b9::catfinity {
    struct CATFINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFINITY>(arg0, 9, b"CATFINITY", b"infinite cats", b"CATCATCATCATCATCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6tsovznpwpkzghhunwvwp6mfnjn7qeqmwmjm65lggzkkbu6p6fa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATFINITY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATFINITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFINITY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

