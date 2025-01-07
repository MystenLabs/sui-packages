module 0x13944753b7023c08fede58f7271fc7d540cb2e3c2e581aa72442378245802bf8::suicorn {
    struct SUICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICORN>(arg0, 6, b"SUICORN", b"Sui Unicorn", x"535549434f524e203a2041206d616a6573746963206d656d6520636f696e207769746820612062696c6c696f6e2d646f6c6c617220647265616d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_unicornconcept_artart_gamecr_847c8609_4b07_46a1_b31c_54ac99eca826_2_1_436fb77a73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

