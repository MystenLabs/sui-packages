module 0x9008d3c50d2b67cd483e7f80878f6269aefc5ba22dce5a1d522f882c518f5245::ninja {
    struct NINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINJA>(arg0, 6, b"NINJA", b"Suininja", b"SUI AND GRENINJA = SUININJA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmwpof7nocof4xs3gxcwgvbb5zsd3xv7kwlxd76wxl5jvpbbj7da")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NINJA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

