module 0x6da7727a7d4cd12440d48d992126f586639425ddd65a55f53a63413e678bd011::nba {
    struct NBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBA>(arg0, 6, b"NBA", b"Ball", x"54686520776f726c642077696c6c206265207761746368696e67207468652046696e616c732e20536f2077696c6c2074686579207365652042414c4c2e202e0a204265206561726c792e204265206c6f75642e204265206c6567656e646172792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiax72abifu74se3bsjr6c5avmf2ccm7nwu4orwbmbsbmxgpldfqre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

