module 0x17d65785a542eb30fb5deb26c9a86a443c3b63d5674b9da287714c22b201b31d::gagas {
    struct GAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGAS>(arg0, 6, b"GagaS", b"gaga", b"justbebga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihh7odf2eelytum46tfsxcnu5yx6x6vjkdcwnl5djgar56efgz5ii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAGAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

