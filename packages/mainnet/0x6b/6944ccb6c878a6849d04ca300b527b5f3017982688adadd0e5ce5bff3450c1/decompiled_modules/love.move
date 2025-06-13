module 0x6b6944ccb6c878a6849d04ca300b527b5f3017982688adadd0e5ce5bff3450c1::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 6, b"LOVE", b"Make Love Not War", b"stop the meaningless war", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZPpctnjkgk5BioRLW4RvnHGh9cbm6bvKmpGvvCaUFLVu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

