module 0xb22f878fb7f2bb46932869392306f3e3db196ff49612e414438d62d199156f40::zub {
    struct ZUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUB>(arg0, 6, b"ZUB", b"Zubcat", b"Silly since 2012 shop custom pet merch and more below", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif6v4qxg46cdhlb2pnxzz52ptagngywg6h322ocm2j6dpptuyg6pu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

