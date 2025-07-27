module 0xcc0bc3cc21d96982e4c5107efa0bdbad840a904622098dfc7a852fb91069c25c::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 6, b"GREEN", b"Mr Green", x"56e1bbab6120c491e1bab97020c491e1bb832074e1bb956e67206be1babf74206ce1baa169206e68e1bbaf6e672067c3ac206dc3ac6e682076c3a020485450393620c491c3a3206cc3a06d2063686f2063e1bb996e6720c491e1bb936e672063727970746f207468e1bb9d69206769616e207175612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicprqrfo6ubhwnmxojtbacjcowfvkekh6eexrikmrd266r6ki2idu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GREEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

