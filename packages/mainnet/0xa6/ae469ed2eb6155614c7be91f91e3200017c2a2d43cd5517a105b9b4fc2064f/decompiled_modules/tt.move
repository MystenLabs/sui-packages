module 0xa6ae469ed2eb6155614c7be91f91e3200017c2a2d43cd5517a105b9b4fc2064f::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"tt", x"57652072656c656173656420746865205454204e465420436f6c6c656374696f6e206261636b20696e203230323320666f722074686520417369616e20436f6d6d756e6974792e20444f4e542046414445205553204d4645520a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TT_TC_8v_Wp_w_Gn_GA_Yo8uhq_T_858e60f9ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT>>(v1);
    }

    // decompiled from Move bytecode v6
}

