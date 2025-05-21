module 0xcc8c5904f56622ef1296f4423ea8a2bebdc0df31f844aa183fc0e01ee7b5250e::cwat {
    struct CWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAT>(arg0, 6, b"CWAT", b"Sui Cwat", b"Obviously a cat and obviously lives in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiefow6znqzm7nmpzugymml6o7vy3bbc7yx6fzzzt6ajbh727s6qju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CWAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

