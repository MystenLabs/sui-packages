module 0x9e2f4ad03720d0e44bc0038048e5d8fabb7544fece9ea418adbf01e2ded43901::b_ball {
    struct B_BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BALL>(arg0, 9, b"bBALL", b"bToken BALL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

