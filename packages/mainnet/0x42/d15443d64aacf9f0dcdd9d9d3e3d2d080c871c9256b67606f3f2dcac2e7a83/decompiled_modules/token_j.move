module 0x42d15443d64aacf9f0dcdd9d9d3e3d2d080c871c9256b67606f3f2dcac2e7a83::token_j {
    struct TOKEN_J has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_J, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_J>(arg0, 9, b"TKNJ", b"TOKEN_J", b"Test token J", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/13876/standard/JASMY200x200.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_J>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_J>>(v1);
    }

    // decompiled from Move bytecode v6
}

