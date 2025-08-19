module 0x9501c6efdae11b727554e9ba0ae320c1c6c90b3225462b07b9d167b61a422f71::unk {
    struct UNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNK>(arg0, 6, b"Unk", b"uknown", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiawzanpothp7e626lee7trlzsvzzatin4fjudyx7exjczuztl3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

