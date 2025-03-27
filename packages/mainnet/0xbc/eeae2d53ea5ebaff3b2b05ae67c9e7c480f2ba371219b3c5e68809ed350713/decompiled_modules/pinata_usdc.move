module 0xca5d6a58c939e929e49525e973eab52c4de99e8f24b3a47d0df7fe14ea111b71::pinata_usdc {
    struct PINATA_USDC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &0x2::package::Publisher, arg1: &mut 0x2::coin::TreasuryCap<PINATA_USDC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<PINATA_USDC>(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PINATA_USDC>>(0x2::coin::mint<PINATA_USDC>(arg1, arg2, arg4), arg3);
    }

    fun init(arg0: PINATA_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINATA_USDC>(arg0, 6, b"PINATA USDC", b"PINATA USDC", b"PINATA USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/usdc.png/public")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PINATA_USDC>>(0x2::coin::mint<PINATA_USDC>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINATA_USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINATA_USDC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

