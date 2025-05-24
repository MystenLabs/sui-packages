module 0x9bdd6f5f753c24512a2e57f96179bac779871a3fe6886bcd5bb4ab48cd8c8c31::b_d {
    struct B_D has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_D>(arg0, 9, b"bD", b"bToken D", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_D>>(v1);
    }

    // decompiled from Move bytecode v6
}

