module 0xb434f913fe9eee9f4259508e51af84604f80b9602d3ca9869599ed509580543b::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 6, b"FIRST", b"the first trade", x"4c6567656e642073617973207468697320697320686f772074686520666972737420747261646520776173206d6164652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_Fn_O4_W8_AAO_Bxt_c7fcf31887.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRST>>(v1);
    }

    // decompiled from Move bytecode v6
}

