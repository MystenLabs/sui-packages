module 0x638f79b1ec1dee2db38bc7370c21ee676f46695a1e983eb7239b0324c6059a07::jio {
    struct JIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JIO>(arg0, 9, 0x1::string::utf8(b"JIO"), 0x1::string::utf8(b"joi"), 0x1::string::utf8(b"joi (JIO)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JIO>>(0x2::coin_registry::finalize<JIO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

