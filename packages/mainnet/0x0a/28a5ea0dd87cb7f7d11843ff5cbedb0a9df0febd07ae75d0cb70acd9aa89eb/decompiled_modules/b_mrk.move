module 0xa28a5ea0dd87cb7f7d11843ff5cbedb0a9df0febd07ae75d0cb70acd9aa89eb::b_mrk {
    struct B_MRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MRK>(arg0, 9, b"bMRK", b"bToken MRK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

