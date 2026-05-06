module 0xdeb1a4e38c83890153e50f93d9bad9b90cf28b0bf65c0cdc631ada9240170fa6::ktt {
    struct KTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTT>(arg0, 6, b"KTT", b"Kitty", b"Token new on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibqgpxfgw2s3nehoi6ovsgofvdw6p6zfakvkxkzc5dzntyrrs4c7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

