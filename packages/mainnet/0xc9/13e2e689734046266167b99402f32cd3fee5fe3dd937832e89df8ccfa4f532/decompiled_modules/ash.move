module 0xc913e2e689734046266167b99402f32cd3fee5fe3dd937832e89df8ccfa4f532::ash {
    struct ASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH>(arg0, 6, b"ASH", b"TEAM ASH", x"74617567687420757320726967687420616e642077726f6e670a6e6576657220676976652075700a73746179207472756520746f20796f75722068656172740a696620796f752062656c6965766520696e20736f6d657468696e6720666967687420666f722069740a2441534820697320746865207469636b6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihiprq2qi3vd4brelztcgm4yrxcqpfj2zy3pxs7cxhaqw7byddyyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

