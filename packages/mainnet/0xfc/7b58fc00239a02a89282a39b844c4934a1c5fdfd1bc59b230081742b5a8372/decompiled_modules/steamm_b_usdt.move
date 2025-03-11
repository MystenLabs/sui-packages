module 0xfc7b58fc00239a02a89282a39b844c4934a1c5fdfd1bc59b230081742b5a8372::steamm_b_usdt {
    struct STEAMM_B_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_B_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_B_USDT>(arg0, 9, b"STEAMM bsuiUSDT", b"STEAMM bToken bsuiUSDT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_B_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_B_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

