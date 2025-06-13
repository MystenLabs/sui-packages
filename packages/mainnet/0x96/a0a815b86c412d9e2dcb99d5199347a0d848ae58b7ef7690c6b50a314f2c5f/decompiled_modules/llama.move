module 0x96a0a815b86c412d9e2dcb99d5199347a0d848ae58b7ef7690c6b50a314f2c5f::llama {
    struct LLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMA>(arg0, 6, b"LLAMA", b"llamaindex", b"llamaindex just landed there for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigavbkgffx3ajszeqmfv32xywlz654mrp6sow4zmc5r7gka32srzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LLAMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

