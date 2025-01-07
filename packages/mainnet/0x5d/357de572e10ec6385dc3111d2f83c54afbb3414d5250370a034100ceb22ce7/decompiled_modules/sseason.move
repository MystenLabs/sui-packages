module 0x5d357de572e10ec6385dc3111d2f83c54afbb3414d5250370a034100ceb22ce7::sseason {
    struct SSEASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSEASON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSEASON>(arg0, 6, b"SSEASON", b"sui season", b"welcome sir to the start of the SUI season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B0_D1_AB_0_D_4_EF_9_4_ECD_A3_F2_641_E76_FE_9_DDC_c57cb200e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSEASON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSEASON>>(v1);
    }

    // decompiled from Move bytecode v6
}

