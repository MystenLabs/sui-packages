module 0xfcac4ba5a69a549fcb0c45b69348eaee68a5958cea8df621faaac4816256ca2f::satm {
    struct SATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATM>(arg0, 6, b"SATM", b"SatoshiMining", b"Satoshi First Wave is coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidgb2fcfhzw7jj2pow64byc7w2nzry4driuudl2yx2xtsatd63nma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

