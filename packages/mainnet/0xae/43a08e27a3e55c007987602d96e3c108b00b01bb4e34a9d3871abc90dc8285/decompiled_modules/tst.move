module 0xae43a08e27a3e55c007987602d96e3c108b00b01bb4e34a9d3871abc90dc8285::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TST1", b"This is the token for everyone want to yield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsaiyfasopsxdiyu7dtmvjdxle6amr3ascbygkjhtixnm66c6uki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

