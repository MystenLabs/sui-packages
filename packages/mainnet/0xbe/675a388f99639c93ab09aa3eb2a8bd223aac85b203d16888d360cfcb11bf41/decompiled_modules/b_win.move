module 0xbe675a388f99639c93ab09aa3eb2a8bd223aac85b203d16888d360cfcb11bf41::b_win {
    struct B_WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WIN>(arg0, 9, b"bWIN", b"bToken WIN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

