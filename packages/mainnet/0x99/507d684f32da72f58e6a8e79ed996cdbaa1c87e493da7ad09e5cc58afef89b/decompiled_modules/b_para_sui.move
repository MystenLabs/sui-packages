module 0x99507d684f32da72f58e6a8e79ed996cdbaa1c87e493da7ad09e5cc58afef89b::b_para_sui {
    struct B_PARA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PARA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PARA_SUI>(arg0, 9, b"bParaSui", b"bToken ParaSui", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PARA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PARA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

