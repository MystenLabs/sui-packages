module 0xb2bbf66df9b565f2004a62fff3bfd21143728d6a5b7b1f8749942b44406a35a3::b_usdc {
    struct B_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDC>(arg0, 9, b"bUSDC", b"bToken USDC", b"Steamm bToken", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<B_USDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

