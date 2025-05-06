module 0xd087d4cd9f4f602ce54b6ae919a40479dfc07162cfe6d570f004d1452f4b6ed::b_suinu {
    struct B_SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUINU>(arg0, 9, b"bSUINU", b"bToken SUINU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

