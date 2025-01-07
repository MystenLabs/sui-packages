module 0xee3cbd4aba24b0be8eb3d36f04118f39c334d8dd9731c8191d5caf5124e3140b::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"Pump Sui", x"416e20616e74692d7275672043726f77642046756e64696e6720506c6174666f726d20746f20537570706f727420437265617469766520446576656c6f7065727320696e20537569206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_20241123_151817_0000_7a86bc567b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

