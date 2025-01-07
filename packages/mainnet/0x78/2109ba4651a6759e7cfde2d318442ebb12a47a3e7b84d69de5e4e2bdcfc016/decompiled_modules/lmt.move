module 0x782109ba4651a6759e7cfde2d318442ebb12a47a3e7b84d69de5e4e2bdcfc016::lmt {
    struct LMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMT>(arg0, 6, b"LMT", b"Little Mermaid", b"Little Mermaid is coming for the crown!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/144_C4_D56_8_ACA_43_EE_B0_B9_B91_ADD_88_CB_95_72b16a38d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

