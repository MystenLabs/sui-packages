module 0x8204fc1ec634b4ad735b094e6d8fa3c83fe1f3894b9cbdf228c997b2f3571b95::gosk {
    struct GOSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSK>(arg0, 6, b"Gosk", b"Gogo", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiao4ed4setihx2dwfznsv2d7hoxsw5x4hmzgb6vbgenz5iiv26qwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

