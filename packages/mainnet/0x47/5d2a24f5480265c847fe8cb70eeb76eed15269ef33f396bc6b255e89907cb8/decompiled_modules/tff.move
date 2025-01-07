module 0x475d2a24f5480265c847fe8cb70eeb76eed15269ef33f396bc6b255e89907cb8::tff {
    struct TFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFF>(arg0, 6, b"TFF", b"The Fartfather", x"4f4d47204b4f4a494d412046415254454420544841542057415320534f20415745534f4d452c2054525554484c59204f4e45204f4620544845204649525354204641525420424153454420414354494f4e0a54656c656772616d3a2068747470733a2f2f742e6d652f6b6f6a696d61666172740a547769747465723a2068747470733a2f2f782e636f6d2f6b6f6a696d61666172740a576562736974653a20687474703a2f2f746865666172746661746865722e736974652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241219_204640_174_68bb42ecd9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

