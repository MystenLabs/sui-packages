module 0x40c0a99dec845b3be333342a6d915c801f40395148c970c221fb67f7753dbf75::b_wht {
    struct B_WHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WHT>(arg0, 9, b"bWHT", b"bToken WHT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

