module 0x5832c96a01584be50648e34d458cc4f2369fd2962a7e7ebe20801b09c0566e47::b_xcv {
    struct B_XCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XCV>(arg0, 9, b"bXCV", b"bToken XCV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

