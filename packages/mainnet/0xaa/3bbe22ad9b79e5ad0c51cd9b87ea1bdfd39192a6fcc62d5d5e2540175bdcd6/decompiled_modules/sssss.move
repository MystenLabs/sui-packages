module 0xaa3bbe22ad9b79e5ad0c51cd9b87ea1bdfd39192a6fcc62d5d5e2540175bdcd6::sssss {
    struct SSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSSS>(arg0, 6, b"SSSSS", b"aaaa", b"aaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiczg5st355uatqif7zlsno3crcrvjcrns2v4qpybfla4wip4sowi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSSSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

