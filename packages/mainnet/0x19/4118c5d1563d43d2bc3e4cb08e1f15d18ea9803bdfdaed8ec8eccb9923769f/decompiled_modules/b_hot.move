module 0x194118c5d1563d43d2bc3e4cb08e1f15d18ea9803bdfdaed8ec8eccb9923769f::b_hot {
    struct B_HOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HOT>(arg0, 9, b"bHOT", b"bToken HOT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

