module 0x2d039ddabf9efa9ccc0a8b215b20bdabfc6c12b6e8ea0964fe12d0979e7c368e::b_new {
    struct B_NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NEW>(arg0, 9, b"bNEW", b"bToken NEW", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

