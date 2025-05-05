module 0x6f6e69fe17895462bb5193b3decd8e1116fe25891e7f71cac522d67f2f2f4720::b_cnt {
    struct B_CNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CNT>(arg0, 9, b"bCNT", b"bToken CNT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

