module 0xc4fae5438c07f768d807bf8963df861fbfa55071434c7fbe2436261be721f6a1::suiett {
    struct SUIETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIETT>(arg0, 6, b"SUIETT", b"Suiettings", b"Big brain, little gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/png_transparent_computer_icons_student_education_test_business_student_people_logo_business_d0567538ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

