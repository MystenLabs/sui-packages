module 0xda04b4d68cd7304b20a7fd027de7d1b2b1a04f1ecf2ca3a2ed582f952142f56a::tkop {
    struct TKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKOP>(arg0, 6, b"TKOP", b"The King Of Pineapple", b"The King Of Pineapple Who hold BTC for prosperity and Wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic34aqcs7du6hnmpy7hh3btsuv6qxw6srbpg3hwwlhcdyt7ux5jz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TKOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

