module 0xff3b927f03a5f9f8c5d6fdd78999a3a24ebc24fb7499fc4dd76e807dfdaf1fd::visionai {
    struct VISIONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISIONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VISIONAI>(arg0, 6, b"VISIONAI", b"VISIONARY AI", b"Your guide to the future. Provides personalized predictions based on your name and city, combining artificial intelligence and predictive analytics to reveal what the destination has in store for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735856333154.39")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VISIONAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISIONAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

