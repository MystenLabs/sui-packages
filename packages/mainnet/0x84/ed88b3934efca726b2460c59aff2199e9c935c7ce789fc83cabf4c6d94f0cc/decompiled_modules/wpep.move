module 0x84ed88b3934efca726b2460c59aff2199e9c935c7ce789fc83cabf4c6d94f0cc::wpep {
    struct WPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPEP>(arg0, 6, b"WPEP", b"wPepe", x"577261707065642050657065206f6e205355492c2074686520616c7465722065676f206f662074686520766972616c204d617474206675726965206368617261637465722e205065706520697320696d70726f7665642077697468207365616d6c6573732074726164696e6720636f6d6d756e69747920746f6b656e2c2050324520616e64207772617070656421202457504550450a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L7_L_Gy4_R6_400x400_0a1736a398.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WPEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

