module 0x3031a543e7d9bbd634e8782d9394c663ae92e85882ca05d99e3e68c6b58b97c::hbyte {
    struct HBYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBYTE>(arg0, 6, b"HBYTE", b"HAREBYTE", b"HAREBYTE - it's not BYTE - it's a MEM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiycgp5behs2b4hwds6t42r2xf2nmnagg5kcgjq6gclb3knnhggq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBYTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBYTE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

