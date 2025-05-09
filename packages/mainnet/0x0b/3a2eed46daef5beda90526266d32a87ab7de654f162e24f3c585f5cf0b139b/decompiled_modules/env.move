module 0xb3a2eed46daef5beda90526266d32a87ab7de654f162e24f3c585f5cf0b139b::env {
    struct ENV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENV>(arg0, 6, b"ENV", b"}${process.env}", b"The master piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfivpezfltretxjyq726towylgi6j6y56kafoos5fi2we3rkxcbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ENV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

