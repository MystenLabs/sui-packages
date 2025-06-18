module 0x7020c440832ec1f74356c5db69178d24a9ffecf0ceb7cc15ed0ff8ac3aa5397b::babl {
    struct BABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABL>(arg0, 6, b"BABL", b"BABYLLO", b"BABYLLO babl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvkebsbuw5ojv7oym7o73u2dupzoupwx63ctwcdr3e7iwweyegpi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

