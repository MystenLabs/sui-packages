module 0x7c3f0c40b5d4697ac073dc5ba62e776fc41262df9fff806acc72374c1e1ba197::b_spring_sui {
    struct B_SPRING_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SPRING_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SPRING_SUI>(arg0, 9, b"bsSUI", b"bToken sSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SPRING_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SPRING_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

