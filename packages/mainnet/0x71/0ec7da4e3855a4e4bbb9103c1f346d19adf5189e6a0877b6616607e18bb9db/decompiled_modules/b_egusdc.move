module 0x710ec7da4e3855a4e4bbb9103c1f346d19adf5189e6a0877b6616607e18bb9db::b_egusdc {
    struct B_EGUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EGUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EGUSDC>(arg0, 9, b"begUSDC", b"bToken egUSDC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EGUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EGUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

