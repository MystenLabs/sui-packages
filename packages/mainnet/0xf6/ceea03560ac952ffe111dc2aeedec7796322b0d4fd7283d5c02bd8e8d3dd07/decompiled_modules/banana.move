module 0xf6ceea03560ac952ffe111dc2aeedec7796322b0d4fd7283d5c02bd8e8d3dd07::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"BANANA", b"Banana on SUI", x"54686520626573742074726164696e6720626f74206f6e205355492e0a4275696c74206279206f6e2d636861696e20747261646572732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_W5_Aa_QO_5_400x400_d7164a6b0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

