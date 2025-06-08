module 0x60bf32e6ed52e8dca32a07d88a6d154dff386a51b1df11374353adaa0331c3ca::tsn {
    struct TSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSN>(arg0, 6, b"TSN", b"Testing", b"hello world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifi7n5whtu5qxembyoecgidjdvhm5hcmle5y6nwax4tx27llsvgde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

