module 0xa90312a682467c1683a732ba24cea808b75e6f902402dec80ef3f28c29123cee::toiletpaper {
    struct TOILETPAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILETPAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILETPAPER>(arg0, 6, b"TOILETPAPER", b"Sui Toilet Paper", x"54686520657373656e7469616c20726f6c6c20666f722065766572792053756920656e74687573696173742c20776970696e67206177617920796f757220776f727269657320616e6420636c65616e696e6720757020746865206d6573732e205768656e20746865206d61726b65742067657473206d657373792c206d616b65207375726520796f75766520676f742053756920546f696c6574205061706572206f6e2068616e64210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/umutcklc_UPA_Revival_art_style_thick_lines_mascot_logo_mascot_a_2d046430_3674_4cf0_b0ab_9694ba670ec5_1_2b6332af8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILETPAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOILETPAPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

