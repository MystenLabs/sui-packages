module 0xa939ffb43dada13e4dcc61e6ced30962aa96afa74d0182b0263e1bd0dcb2f19f::moondog {
    struct MOONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOG>(arg0, 6, b"MOONDOG", b"MOONDOG SUI", x"4d6f6f6e646f6720697320612062696720646f672077697468206120736d616c6c20647265616d2e47726f77696e672075702068756e74696e6720696e20746865207661737420657870616e7365206f660a74686520536962657269616e2077696c6465726e6573732c204d6f6f6e646f67207370656e74206d616e7920736c6565706c657373206e69676874732073746172696e672075702061742074686520736b792e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_54a9f95575.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

