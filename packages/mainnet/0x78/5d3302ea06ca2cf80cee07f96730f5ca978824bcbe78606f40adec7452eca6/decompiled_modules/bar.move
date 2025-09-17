module 0x785d3302ea06ca2cf80cee07f96730f5ca978824bcbe78606f40adec7452eca6::bar {
    struct BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAR>(arg0, 6, b"BAR", b"BARON", b"non", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifazawur7nf6cw5k736h5i26brybpjnuokkw46dx4k4xhjkhvnz2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

