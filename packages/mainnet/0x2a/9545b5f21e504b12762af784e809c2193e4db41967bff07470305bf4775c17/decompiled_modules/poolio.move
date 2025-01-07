module 0x2a9545b5f21e504b12762af784e809c2193e4db41967bff07470305bf4775c17::poolio {
    struct POOLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOLIO>(arg0, 6, b"POOLIO", b"Poolio", b"Poolio the Mascot of all pools on the water network - SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_15_at_10_01_27_PM_1_087abd933d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOLIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOLIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

