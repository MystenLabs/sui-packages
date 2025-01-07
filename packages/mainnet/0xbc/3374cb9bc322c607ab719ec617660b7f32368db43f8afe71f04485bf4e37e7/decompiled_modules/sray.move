module 0xbc3374cb9bc322c607ab719ec617660b7f32368db43f8afe71f04485bf4e37e7::sray {
    struct SRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRAY>(arg0, 6, b"SRAY", b"Stingray Suits", x"5374696e6772617920537569747320746865204772656174657374204d656d6520657665722063726561746564206f6e20535549204e6574776f726b2c207468652070656f706c65732063686f696365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_transpercy_1_ff2d9cb9e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

