module 0x4ad7e8c46d29924a28207052a8b1d96288c4c40a0e7afebe69448cbb25214cee::suicorn {
    struct SUICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICORN>(arg0, 6, b"SUICORN", b"Sui Unicorn", b"Majestic and rare, $SUICORN prances through the Sui Network like pure magic. This mythical creature is here to spread some sparkle and take you on a magical ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_unicornconcept_artart_gamecr_847c8609_4b07_46a1_b31c_54ac99eca826_2_1_7890ea8362.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

