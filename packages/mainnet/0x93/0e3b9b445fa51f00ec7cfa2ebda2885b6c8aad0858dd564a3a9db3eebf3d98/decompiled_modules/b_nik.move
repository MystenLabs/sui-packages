module 0x930e3b9b445fa51f00ec7cfa2ebda2885b6c8aad0858dd564a3a9db3eebf3d98::b_nik {
    struct B_NIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NIK>(arg0, 9, b"bNIK", b"bToken NIK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

