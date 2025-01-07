module 0x838f3b25dcd1e9f9bdb05fad9ddf6e006927974805040beebedee8cb4acd97a9::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"USDC", b"USDC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/usdc.png/public")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        create_currency<COIN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

