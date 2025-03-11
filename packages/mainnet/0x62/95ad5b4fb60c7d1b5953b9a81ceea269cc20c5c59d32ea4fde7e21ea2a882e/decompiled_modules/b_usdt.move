module 0x6295ad5b4fb60c7d1b5953b9a81ceea269cc20c5c59d32ea4fde7e21ea2a882e::b_usdt {
    struct B_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDT>(arg0, 9, b"STEAMM bsuiUSDT", b"STEAMM bToken suiUSDT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

