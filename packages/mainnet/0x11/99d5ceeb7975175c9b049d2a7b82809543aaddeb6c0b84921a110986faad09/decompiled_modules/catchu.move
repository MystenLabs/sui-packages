module 0x1199d5ceeb7975175c9b049d2a7b82809543aaddeb6c0b84921a110986faad09::catchu {
    struct CATCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCHU>(arg0, 6, b"CATCHU", b"Catichu Pokemon", b"Catichu is the first pokemon cat on Sui Blockchain . $CATCHU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiedsimxvb6b2enas2wv4d6nurw5yokwzqs26iejaltokyaj2g6zsm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

