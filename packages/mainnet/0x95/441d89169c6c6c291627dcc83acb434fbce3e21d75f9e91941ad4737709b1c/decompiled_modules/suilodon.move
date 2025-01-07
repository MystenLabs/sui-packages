module 0x95441d89169c6c6c291627dcc83acb434fbce3e21d75f9e91941ad4737709b1c::suilodon {
    struct SUILODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILODON>(arg0, 6, b"SUILODON", b"Sui Megalodon", x"456d657267696e672066726f6d20746865206465657065737420776174657273206f66205375692c20537569204d6567616c6f646f6e2069732074686520756c74696d6174652061706578207072656461746f7220696e2074686520537569206f6365616e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_60_1_ec411993b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

