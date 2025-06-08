module 0xe16ada8b2498d3d706502210c6cf14b2fb36e7bbb06612663195d61e41a10db5::situs {
    struct SITUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SITUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SITUS>(arg0, 6, b"SITUS", b"CETUSS", b"CETUS2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibiddj6g4llfvhwke6ahiw66dj6w5zkwnh66bvoha6s6vi6pljhhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SITUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

