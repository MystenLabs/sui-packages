module 0xd065eb965b6e676a03ed910a22b2e19d561176f5b44ce4d110c4f7911a951ca7::b_gd {
    struct B_GD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GD>(arg0, 9, b"bGD", b"bToken GD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GD>>(v1);
    }

    // decompiled from Move bytecode v6
}

