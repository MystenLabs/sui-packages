module 0xfeebc6d1ec2fc29467b40240ab1a23a9983464b18d0a16405ea313ea681247c3::b_send {
    struct B_SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SEND>(arg0, 9, b"bSEND", b"bToken SEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

