module 0xcc4a84430b6ce34b12b10755892d5b79bb562c04ca48347f5f08ba7a72185fde::suiword {
    struct SUIWORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWORD>(arg0, 6, b"SUIWORD", b"Sword of Sui", x"5769656c64207468652024535549574f524420616e6420637574207468726f75676820746865206e6f6973652e2054686520736861727065737420746f6f6c20696e2074686520537569204e6574776f726b2c20736c617368696e67207468726f75676820636f6d7065746974696f6e207769746820707265636973696f6e20616e6420706f7765722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_swordconcept_artart_gamecrea_6c6a382c_9bb9_4abe_a0d7_9863621ca4a2_56ea2b6f05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

