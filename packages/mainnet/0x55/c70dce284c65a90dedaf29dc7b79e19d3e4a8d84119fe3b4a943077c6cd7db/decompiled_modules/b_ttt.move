module 0x55c70dce284c65a90dedaf29dc7b79e19d3e4a8d84119fe3b4a943077c6cd7db::b_ttt {
    struct B_TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TTT>(arg0, 9, b"bTTT", b"bToken TTT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

