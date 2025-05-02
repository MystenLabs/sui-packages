module 0x1cc8e26862c1c2a1f57bf2d857f7a8d0b8324ef8684cc1b00f2e7fa618a34610::b_zup {
    struct B_ZUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZUP>(arg0, 9, b"bZUP", b"bToken ZUP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

