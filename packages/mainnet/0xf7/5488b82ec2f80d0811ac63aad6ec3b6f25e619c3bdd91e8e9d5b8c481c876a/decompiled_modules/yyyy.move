module 0xf75488b82ec2f80d0811ac63aad6ec3b6f25e619c3bdd91e8e9d5b8c481c876a::yyyy {
    struct YYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYYY>(arg0, 6, b"Yyyy", b"Yuuu", b"ozkok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifotxuusmcvbsjwssqw57s3eo4flvwprybm57zbreuba7cwcw3vme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YYYY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

