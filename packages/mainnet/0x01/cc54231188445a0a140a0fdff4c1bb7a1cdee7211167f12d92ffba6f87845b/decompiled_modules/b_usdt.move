module 0x1cc54231188445a0a140a0fdff4c1bb7a1cdee7211167f12d92ffba6f87845b::b_usdt {
    struct B_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDT>(arg0, 9, b"bsuiUSDT", b"bToken suiUSDT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

