module 0xf5b7dda6f290625ce6f0a8b92d258f0fc4b3c3eca56d530f2c066ec9c50a66bd::b_wht {
    struct B_WHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WHT>(arg0, 9, b"bWHT", b"bToken WHT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

