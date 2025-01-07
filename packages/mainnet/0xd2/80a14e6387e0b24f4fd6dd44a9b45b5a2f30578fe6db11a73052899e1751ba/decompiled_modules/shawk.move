module 0xd280a14e6387e0b24f4fd6dd44a9b45b5a2f30578fe6db11a73052899e1751ba::shawk {
    struct SHAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWK>(arg0, 6, b"SHAWK", b"SHAWK COIN", b"GM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D2_J_Gi_1_D_400x400_7f827aca6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

