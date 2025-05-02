module 0xababc270c5263e01bfa78b42475475d3c754bbd35d4a0ae9f35754e354df117c::b_wve {
    struct B_WVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WVE>(arg0, 9, b"bWVE", b"bToken WVE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

