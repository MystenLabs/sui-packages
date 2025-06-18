module 0x8a6aee754d0037b0876f366aaf0e1d01a30e5372098fc19cb33fa14576a082e8::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 6, b"SDF", b"sdfsd", b"sdfsdsdfsdsdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7hiooadpu47geszazeoyqi3oneugdvqaosdptusfrgxusjqtydq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

