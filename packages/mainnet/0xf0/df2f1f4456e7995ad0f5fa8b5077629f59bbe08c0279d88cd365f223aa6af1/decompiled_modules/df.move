module 0xf0df2f1f4456e7995ad0f5fa8b5077629f59bbe08c0279d88cd365f223aa6af1::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 6, b"DF", b"dfg", b"dfgfgdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrx5vav3gkpuiovmp3ohnbgaau32yve7z3xl6yv5iqpe7i2vicbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

