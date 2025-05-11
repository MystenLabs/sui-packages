module 0x7791dea47bb89e2b397afd8096ded0963d36b3d7c6b10011fa2e1302396c282f::b_up {
    struct B_UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UP>(arg0, 9, b"bUP", b"bToken UP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

