module 0x9abe90c20865d0a9bf013a7fd9066de68d7c08d19bb6b2f40981787ad8a910e5::ps5 {
    struct PS5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS5>(arg0, 6, b"PS5", b"My PS5", x"4d792050533520636f6d696e672073617665206d652066726f6d20616c6c2074686520616920727567732068747470733a2f2f7777772e74696b746f6b2e636f6d2f4073696c6c795f6c696c5f676f6f6662616c6c2f766964656f2f373435323931383039393931383939383833300a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme53wbs_St1yhycc5tf_X_Vs71d_Cwh_UGNU_2u_T_Tx_LM_Xute_EGA_1a17b9d93f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PS5>>(v1);
    }

    // decompiled from Move bytecode v6
}

