module 0x6c057dd7e111179f82860c3c8dde3c1628f083eb541e665dae4786b2f5a199e9::b_bab {
    struct B_BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BAB>(arg0, 9, b"bBAB", b"bToken BAB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

