module 0xcafe1ff98cebde1035b572c7463177a342b0282ede7d82f2fdde03faa7d9aedc::gn {
    struct GN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GN>(arg0, 6, b"GN", b"GNNNN", b"GN World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictlqdxbjkb5ihs44yqp3kpwc4ib5rvtwb7j6c6mr3fkhttllro7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

