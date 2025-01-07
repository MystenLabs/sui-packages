module 0xe3a0378adaee3b1bcf225d516743073ef24877e57c40af60f9887344d9bfdb7f::evdeng {
    struct EVDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVDENG>(arg0, 6, b"EVDENG", b"Evan Deng", b"THE FOUNDER OF SUI TURNED HIPPO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_7_46_54_PM_f1699eade3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

