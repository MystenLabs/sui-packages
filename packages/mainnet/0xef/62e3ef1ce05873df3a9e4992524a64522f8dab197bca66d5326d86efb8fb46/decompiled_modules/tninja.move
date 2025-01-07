module 0xef62e3ef1ce05873df3a9e4992524a64522f8dab197bca66d5326d86efb8fb46::tninja {
    struct TNINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNINJA>(arg0, 6, b"TNINJA", b"Turtles Ninja", x"54686520666972737420616e64206f726967696e616c20547572746c6573204e696e6a61206f6e205375692c206c65642062792074686520636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cho_uaung_2bd6cf21f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNINJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

