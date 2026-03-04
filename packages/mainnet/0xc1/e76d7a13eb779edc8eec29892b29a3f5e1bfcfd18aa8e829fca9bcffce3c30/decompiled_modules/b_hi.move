module 0xc1e76d7a13eb779edc8eec29892b29a3f5e1bfcfd18aa8e829fca9bcffce3c30::b_hi {
    struct B_HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HI>(arg0, 9, b"bHI", b"bToken HI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HI>>(v1);
    }

    // decompiled from Move bytecode v6
}

