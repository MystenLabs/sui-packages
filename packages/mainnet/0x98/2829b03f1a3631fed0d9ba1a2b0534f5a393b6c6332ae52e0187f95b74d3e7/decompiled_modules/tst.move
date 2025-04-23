module 0x982829b03f1a3631fed0d9ba1a2b0534f5a393b6c6332ae52e0187f95b74d3e7::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TeST", b"Nono", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidlthgjfzbnhjaisw6brg7wrskz5km7fxxcyvet3x4pmw3vsjfcja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

