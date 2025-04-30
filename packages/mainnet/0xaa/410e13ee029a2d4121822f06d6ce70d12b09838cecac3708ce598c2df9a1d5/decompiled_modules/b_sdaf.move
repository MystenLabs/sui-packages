module 0xaa410e13ee029a2d4121822f06d6ce70d12b09838cecac3708ce598c2df9a1d5::b_sdaf {
    struct B_SDAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SDAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SDAF>(arg0, 9, b"bSDAF", b"bToken SDAF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SDAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SDAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

