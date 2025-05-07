module 0xfcac99d8e835532e19fd9da26e3dd44a432d072a14ba95a01d41681373cb8528::kro {
    struct KRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRO>(arg0, 6, b"KRO", b"Kuro", b"Kuro is the alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiawl5nahij7zgz2r22xj23dhgfziycfhnw7hyczob7cdjzprmzaf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

