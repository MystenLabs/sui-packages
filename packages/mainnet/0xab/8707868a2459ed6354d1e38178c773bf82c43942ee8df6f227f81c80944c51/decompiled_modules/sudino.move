module 0xab8707868a2459ed6354d1e38178c773bf82c43942ee8df6f227f81c80944c51::sudino {
    struct SUDINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDINO>(arg0, 6, b"SUDINO", b"Sui Dino", b"Rawrrr be afraid be very afraid!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_08_at_11_16_38_PM_642d05a429.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

