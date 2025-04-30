module 0xe5a4f2eafdfc3da9ec63735e749cc6ddecc19cb60a990d0f3b08358339ae92c5::uuc {
    struct UUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUC>(arg0, 6, b"UUC", b"UEFA UNITY OFFICIAL COIN", b"Official UEFA UNITY COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaj665hqqui46yejq54doqqeq6coihvwvnz3f4n4oipuesvgmrqpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UUC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

