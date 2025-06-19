module 0x52e9c4155a04d7e5ef3cbb23a6830ed2ee5905d38fa80598cf39266bd97a9b06::sep {
    struct SEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEP>(arg0, 6, b"SEP", b"Sui Eater Protocol", b"Sui Eater Protocol on Sui Network launched on https://moonbags.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7muhzhxvmfh4svg6n2me7eesbjibrzj4ptb2oja4hposkxmsjti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

