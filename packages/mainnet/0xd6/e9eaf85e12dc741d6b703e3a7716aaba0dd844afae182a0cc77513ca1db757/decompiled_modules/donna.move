module 0xd6e9eaf85e12dc741d6b703e3a7716aaba0dd844afae182a0cc77513ca1db757::donna {
    struct DONNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONNA>(arg0, 6, b"DONNA", b"Donna Trump", b"In a parallel universe, our President Donald Trump was nOt conservative, and he went by 'Donna'.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/opdseqwasenart_image_A_Ym_OPE_Hv_1730779401816_raw_2_efb1211edd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

