module 0x3c6e067dc16e296e75e44d8350395bf1bbcd16432b7f87e4eadde8c2ba47241a::chui {
    struct CHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUI>(arg0, 6, b"CHUI", b"Chuibacca", b"The Republic Of Sui Needs You! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_25_at_7_53_29_PM_a6897720ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

