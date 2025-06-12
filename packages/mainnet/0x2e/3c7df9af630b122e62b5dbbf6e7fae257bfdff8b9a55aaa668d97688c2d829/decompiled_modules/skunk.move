module 0x2e3c7df9af630b122e62b5dbbf6e7fae257bfdff8b9a55aaa668d97688c2d829::skunk {
    struct SKUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKUNK>(arg0, 6, b"Skunk", b"Skunk on Sui", x"5765207374696e6b20616e64207765206b6e6f77206974210a0a54686520736b756e6b20796f75206469646e74206b6e6f7720796f75206e6565646564206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxrejoe43j6jasmm4vfmctv7mdm7ylgve67objrjxmijdtnyrhey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKUNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

