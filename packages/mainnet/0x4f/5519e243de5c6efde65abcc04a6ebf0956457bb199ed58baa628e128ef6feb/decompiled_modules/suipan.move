module 0x4f5519e243de5c6efde65abcc04a6ebf0956457bb199ed58baa628e128ef6feb::suipan {
    struct SUIPAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAN>(arg0, 6, b"SUIPAN", b"Sui Panda", b"The Only Panda On Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_5_01_43_PM_11f91f0158.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

