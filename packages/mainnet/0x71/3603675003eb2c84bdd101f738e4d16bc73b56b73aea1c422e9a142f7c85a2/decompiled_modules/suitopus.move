module 0x713603675003eb2c84bdd101f738e4d16bc73b56b73aea1c422e9a142f7c85a2::suitopus {
    struct SUITOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOPUS>(arg0, 6, b"SUITOPUS", b"Sui Octopus", x"4d65657420537569204f63746f707573202824535549544f505553292c2074686520736d617274657374206f6620746865207365612e205468697320636c65766572206f63746f70757320697320726561647920746f206e6176696761746520746865206465657020776174657273206f66205375692c20737072656164696e67206974732074656e7461636c65732066617220616e6420776964652c20616e64206f7574736d617274696e672065766572797468696e6720696e2069747320706174682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_octopusgolden_coin_eyescoins_32a05e2b_24dc_4c07_8b60_bd03395c3e0e_1_fac0f18a75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

