module 0xffb0330233992db1067b80dde1d354e4e0a5f08156ba35c72613d62e4ebff783::b_loli {
    struct B_LOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LOLI>(arg0, 9, b"bLOLI", b"bToken LOLI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

