module 0xd8cedaa7817d1d0e2446fc23cf6145e916bc326d4718e30fd9946c6b9ada8215::van {
    struct VAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAN>(arg0, 6, b"VAN", b"Van Gohmon", b"Discover our site and get to know Van Gohmon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeignqaiki6lerq6vuozo2pwtubjcbcgnqjqwklmoje2a4cfeivzqya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

