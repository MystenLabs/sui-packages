module 0xca3d099fba7b063414870ad2e0765e844f46ee83489519e2e9ec2a2a763158ec::pchu {
    struct PCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCHU>(arg0, 6, b"PCHU", b"PCHU ON SUI", b"Inspired by that yellow rat with attitude, Join the $PCHU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaz5rots37melwg42eyulkw7q6ahdsliwxk75scgbiay3chlhwfcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

