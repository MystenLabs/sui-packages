module 0x216714e6c9e5ca6a66e8fd370bb1436d588f0c3b0303f2315579bd760346e650::ggnnsui {
    struct GGNNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGNNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGNNSUI>(arg0, 6, b"Ggnnsui", b"Good night suii", b"Good night sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaz5dmrtuagp2q7lg6ycwywxza4rzgaismyxx5pzdugbcj6tiymjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGNNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GGNNSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

