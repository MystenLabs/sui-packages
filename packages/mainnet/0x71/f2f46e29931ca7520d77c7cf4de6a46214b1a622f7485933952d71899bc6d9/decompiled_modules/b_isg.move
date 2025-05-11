module 0x71f2f46e29931ca7520d77c7cf4de6a46214b1a622f7485933952d71899bc6d9::b_isg {
    struct B_ISG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ISG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ISG>(arg0, 9, b"bISG", b"bToken ISG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ISG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ISG>>(v1);
    }

    // decompiled from Move bytecode v6
}

