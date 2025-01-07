module 0xc3d92dd648d4062e2f7bf3739b97d9907ca3e89e8f738c45965c14db2d8596::suisey {
    struct SUISEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEY>(arg0, 6, b"SUISEY", b"Suisey", b"Welcome to Suisey! The Blue Chansey Pokemon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_6_50_29_PM_f7613dde75.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

