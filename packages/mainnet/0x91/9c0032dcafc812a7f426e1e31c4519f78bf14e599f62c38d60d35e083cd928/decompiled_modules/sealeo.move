module 0x919c0032dcafc812a7f426e1e31c4519f78bf14e599f62c38d60d35e083cd928::sealeo {
    struct SEALEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALEO>(arg0, 6, b"SEALEO", b"SEALEO SUI", b"Sealeo promises an entertaining journey through decentralized technology, complete with Sealeo themed wordplay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffi4rhjlh3y6fo4d56z6v6wbsbjzjq76saxwi4aojku66gopabzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEALEO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

