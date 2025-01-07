module 0x8fe298f4e6f152c45dd739971da30e5f6709a074d6493acd93a2798a3a8f4a68::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 6, b"SUIRO", b"Suiro The Dragon", b"Suiro The Dragon's purpose is to be the first Dragon to bridge the elements. Sui will host an awakening like no other...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_13_at_3_06_28_PM_d6f55fe941.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

