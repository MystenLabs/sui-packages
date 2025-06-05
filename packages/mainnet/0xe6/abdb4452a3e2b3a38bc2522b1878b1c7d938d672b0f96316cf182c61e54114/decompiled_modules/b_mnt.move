module 0xe6abdb4452a3e2b3a38bc2522b1878b1c7d938d672b0f96316cf182c61e54114::b_mnt {
    struct B_MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MNT>(arg0, 9, b"bMNT", b"bToken MNT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

