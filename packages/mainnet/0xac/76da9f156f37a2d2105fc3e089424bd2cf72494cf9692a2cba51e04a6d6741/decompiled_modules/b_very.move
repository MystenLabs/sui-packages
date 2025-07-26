module 0xac76da9f156f37a2d2105fc3e089424bd2cf72494cf9692a2cba51e04a6d6741::b_very {
    struct B_VERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_VERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_VERY>(arg0, 9, b"bVERY", b"bToken VERY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_VERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_VERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

