module 0xf0e4d9bd2978cab922d0bfbe8932962c6224e4cc06f1f92078bebdb97ca06019::dfg {
    struct DFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFG>(arg0, 6, b"DFG", b"fdgdfg", b"SDFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieyssgyx53mwn5g7pxoqntosrerbqt6qrosos2jwyeqylbf377zmi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

