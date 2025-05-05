module 0x462bc1ce18b5b2a50af93ef4bcb0ee282ea55787757c9698b211586e06570bbe::b_eth {
    struct B_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ETH>(arg0, 9, b"bsuiETH", b"bToken suiETH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

