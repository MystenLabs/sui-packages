module 0xf1726b216e702967fcbe3d65d39b7770a56f574cbb1d4dc3d7f5aab3272dda18::genies {
    struct GENIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIES>(arg0, 6, b"GENIES", b"SUI Genie", b"What's your three wishes?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MGA_LOGO_2_6_4c08790ed5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

