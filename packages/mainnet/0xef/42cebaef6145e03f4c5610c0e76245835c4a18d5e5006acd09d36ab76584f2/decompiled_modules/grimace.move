module 0xef42cebaef6145e03f4c5610c0e76245835c4a18d5e5006acd09d36ab76584f2::grimace {
    struct GRIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIMACE>(arg0, 6, b"GRIMACE", b"Grimace on Sui", b"First Grimace on Sui: https://grimaceonsui.store", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pape_shap_Bww_EJI_6_F_300x219_253d4fcfdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

