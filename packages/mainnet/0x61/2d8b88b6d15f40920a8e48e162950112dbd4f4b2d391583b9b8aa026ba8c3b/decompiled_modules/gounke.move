module 0x612d8b88b6d15f40920a8e48e162950112dbd4f4b2d391583b9b8aa026ba8c3b::gounke {
    struct GOUNKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOUNKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOUNKE>(arg0, 6, b"GOUNKE", b"Gounke Ghoper", x"476f756e6b652047686f706572210a426172656c7920667275697466756c2e20426172656c792075736566756c2e2046756c6c79207265616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaohko7jpeccgolmltlk4zdgmitlhdzpvbmft6kom6ruhsv3kgakq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOUNKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOUNKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

