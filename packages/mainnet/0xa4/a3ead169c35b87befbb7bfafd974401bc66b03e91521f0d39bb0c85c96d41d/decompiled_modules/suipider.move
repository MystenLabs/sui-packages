module 0xa4a3ead169c35b87befbb7bfafd974401bc66b03e91521f0d39bb0c85c96d41d::suipider {
    struct SUIPIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIDER>(arg0, 6, b"SUIPIDER", b"Spider Sui", x"537069646572205375692c20746865207765622d736c696e676572206f6620746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_spiderconcept_artart_gamecre_98aeacbd_bbce_465f_b96e_c180347735ca_1_0d35341063.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

