module 0xfdabf3830225ee1e5c1474478eca54847a32b8c703f8b9c53c1f76465ccba29f::b_usdc {
    struct B_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDC>(arg0, 9, b"bUSDC", b"bToken USDC", b"Steamm bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TODO")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

