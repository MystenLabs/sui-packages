module 0x48ec9faa68ebb8905e3f335345c82667cfba8fa860533089c9209ad3f1337c33::kun {
    struct KUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUN>(arg0, 6, b"KUN", b"KUN LEGEND", x"4b756e2069732061206c6567656e646172792066697368207769746820746865206162696c69747920746f207472616e7363656e6420616c6c206c696d69746174696f6e732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_3ad776b65b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

