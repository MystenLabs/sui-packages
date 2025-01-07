module 0x4024ccda0fbd59cf7b8b9c77e9264b3047b1efad25786e99957b4112278c51e3::bluecat {
    struct BLUECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECAT>(arg0, 6, b"BLUECAT", b"Blue Cat", b"just a Blue Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YU_8_Cvn_G3_400x400_aceb3c4a8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

