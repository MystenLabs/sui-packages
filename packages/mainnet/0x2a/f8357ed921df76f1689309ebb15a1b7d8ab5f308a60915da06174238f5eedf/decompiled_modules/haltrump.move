module 0x2af8357ed921df76f1689309ebb15a1b7d8ab5f308a60915da06174238f5eedf::haltrump {
    struct HALTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALTRUMP>(arg0, 6, b"HALTRUMP", b"HALLOWEEN TRUMP", b"Trump wishes you a Happy Halloween!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_15c65ad7_a483_48f5_9e84_2917f7230ba5_1_3df077df7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

