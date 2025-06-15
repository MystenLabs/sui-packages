module 0x198fa1eafbe3a7dbd437d4e3afb7afe84a90f4f09b9ea902964d88c5579fa52b::asdf {
    struct ASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDF>(arg0, 6, b"ASDF", b"asd", b"df", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigavbkgffx3ajszeqmfv32xywlz654mrp6sow4zmc5r7gka32srzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

