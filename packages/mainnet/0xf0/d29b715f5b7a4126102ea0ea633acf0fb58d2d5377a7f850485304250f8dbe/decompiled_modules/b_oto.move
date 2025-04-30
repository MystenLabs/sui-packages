module 0xf0d29b715f5b7a4126102ea0ea633acf0fb58d2d5377a7f850485304250f8dbe::b_oto {
    struct B_OTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OTO>(arg0, 9, b"bOTO", b"bToken OTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

