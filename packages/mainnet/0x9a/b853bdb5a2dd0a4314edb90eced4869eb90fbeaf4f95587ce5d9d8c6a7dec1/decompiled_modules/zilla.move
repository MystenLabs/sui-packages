module 0x9ab853bdb5a2dd0a4314edb90eced4869eb90fbeaf4f95587ce5d9d8c6a7dec1::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILLA>(arg0, 6, b"ZILLA", b"BobZilla", b"The Rebirth of a Fossil Named BobZilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifd6up37a3nmqnxrmtjaweebj44gjtzspnr7hhtsvjrjrpgygfpkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZILLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

