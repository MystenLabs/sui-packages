module 0xe40abd9fb7c40324dece6ed839d7bfc9e15913c7d0f5d55a38ec34eaa567e83f::b_mrk {
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

