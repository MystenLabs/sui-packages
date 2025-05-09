module 0x25a72313936c256dc8cda2b4ad70414900ab99b621d187fe16fea49eda33c2e::b_g {
    struct B_G has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_G>(arg0, 9, b"bG", b"bToken G", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_G>>(v1);
    }

    // decompiled from Move bytecode v6
}

