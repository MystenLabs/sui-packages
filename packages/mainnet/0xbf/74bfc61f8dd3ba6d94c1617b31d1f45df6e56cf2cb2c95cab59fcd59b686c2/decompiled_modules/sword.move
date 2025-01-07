module 0xbf74bfc61f8dd3ba6d94c1617b31d1f45df6e56cf2cb2c95cab59fcd59b686c2::sword {
    struct SWORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWORD>(arg0, 6, b"SWORD", b"Sui Sword", x"5769656c64207468652053574f524420616e6420637574207468726f75676820746865206e6f6973652e2054686520736861727065737420746f6f6c20696e2074686520537569204e6574776f726b2c20736c617368696e67207468726f75676820636f6d7065746974696f6e207769746820707265636973696f6e20616e6420706f7765722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_swordconcept_artart_gamecrea_d7c22a9d_1685_4c36_8b13_f596c43442df_d85379e1f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

