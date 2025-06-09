module 0xb24f3934e28173e279cb4295c3b0c238b002d84e78336b79d9233f74309d2c80::sfm {
    struct SFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFM>(arg0, 6, b"SFM", b"Safemoon", x"536166656d6f6f6e206f6e2053554920205468652052657475726e206f662061204c6567656e640a536166656d6f6f6e20646566696e656420612067656e65726174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicub2tq4yolqvuiaxrz4mv4ctluc2towmobvxveg4tdoci5wjk5wy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

