module 0x257254ce29cc0f2f5078badf2d42f7a02e9d59073944bece483377b0e9d0d3c4::piradog {
    struct PIRADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRADOG>(arg0, 6, b"PIRADOG", b"Pirate Dog", b"The wildest pirate but kind to the helpless he was born in the Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiauqjnbadukfeu2qsji2ezpeorvtlo5e6orqgx3cctrorcknwhq2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIRADOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

