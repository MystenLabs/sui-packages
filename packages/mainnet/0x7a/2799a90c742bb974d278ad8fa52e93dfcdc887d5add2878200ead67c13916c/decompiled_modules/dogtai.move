module 0x7a2799a90c742bb974d278ad8fa52e93dfcdc887d5add2878200ead67c13916c::dogtai {
    struct DOGTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTAI>(arg0, 6, b"DOGTAI", b"DogTranslatorAI", x"4576657220776f6e6465726564207768617420796f757220646f67206973205245414c4c59207468696e6b696e673f0a576974682074686520446f67205472616e736c61746f722041692c20796f752063616e2066696e616c6c79206465636f64652074686f7365206261726b7320616e642067726f776c7320696e746f2061637475616c20776f72647321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2025_01_14_at_16_41_54_e6068342c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

