module 0x4981bf86c659700b080c69902fe27f4d19f95d0268ed4c64de9471dc8deafd70::suipanda {
    struct SUIPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANDA>(arg0, 6, b"SUIPANDA", b"Sui Panda", x"526f6c6c696e67206f6e746f20537569207769746820612077686f6c65206c6f74206f662066756e2c207468697320746f6b656e20697320616c6c2061626f7574206368696c6c20766962657320616e642061206c6f766520666f722062616d626f6f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_magical_pandaconcept_artart_gamec_ab031c07_e195_4557_abe8_172b972dd06b_1_0a598d4e36.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

