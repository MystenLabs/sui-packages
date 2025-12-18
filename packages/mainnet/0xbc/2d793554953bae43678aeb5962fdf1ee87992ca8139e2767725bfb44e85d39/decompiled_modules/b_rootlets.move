module 0xbc2d793554953bae43678aeb5962fdf1ee87992ca8139e2767725bfb44e85d39::b_rootlets {
    struct B_ROOTLETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ROOTLETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ROOTLETS>(arg0, 9, b"bROOTLETS", b"bToken ROOTLETS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ROOTLETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ROOTLETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

