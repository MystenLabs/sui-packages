module 0x740ad8b7e66430e552d42f1883fdb17a1a9da99f8bca6a11e8d5e68830447c97::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"Siu", b"Sui", b"Siusiu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifohoubkljshzm4uin43qtz5rcxagadcxxp2zc6cvflfhoybls6oy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

