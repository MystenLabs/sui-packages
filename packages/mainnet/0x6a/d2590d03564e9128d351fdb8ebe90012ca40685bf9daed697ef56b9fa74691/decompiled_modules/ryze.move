module 0x6ad2590d03564e9128d351fdb8ebe90012ca40685bf9daed697ef56b9fa74691::ryze {
    struct RYZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYZE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RYZE>(arg0, 6, b"RYZE", b"Ryze OS by SuiAI", x"4275696c7420666f7220707265636973696f6e20616e64207363616c6162696c6974792c2069742064656c6976657273207265616c2d74696d6520696e7369676874732c2020646174612070726f63657373696e672c20616e64206566666f72746c65737320706c6174666f726d20696e7465726f7065726162696c697479e28094676976696e6720796f7520616e206564676520696e20576562332e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2179_26d3502a5d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RYZE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYZE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

