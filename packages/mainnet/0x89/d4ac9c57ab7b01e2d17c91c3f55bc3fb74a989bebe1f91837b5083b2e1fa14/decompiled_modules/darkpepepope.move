module 0x89d4ac9c57ab7b01e2d17c91c3f55bc3fb74a989bebe1f91837b5083b2e1fa14::darkpepepope {
    struct DARKPEPEPOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKPEPEPOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKPEPEPOPE>(arg0, 6, b"DarkPepePope", b"Dark Pepe Pope", x"4461726b205065706520506f70653a2054686520477561726469616e206f66204461726b6e65737320496e206120776f726c6420776865726520736861646f777320616e64206c6967687420636f6d7065746520666f7220646f6d696e616e63652c20616e20656e69676d617469632066696775726520656d65726765733a204461726b205065706520506f70652e20436c616420696e20696d706f73696e6720626c61636b20726f6265732c2073796d626f6c697a696e6720706f77657220616e642070617373696f6e2c20686520697320746865206b6565706572206f662074686520756e6976657273652773206461726b65737420736563726574732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_LTX_2rvx3_Gj_Jow_U_Hac_Ttem_Hf6_U6_Pvy_A_Fu9wo_G621_Ak8_D_56eacdc97e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKPEPEPOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKPEPEPOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

