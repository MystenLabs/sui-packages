module 0xda87cb0d303f3cdbb42f66fa09791cb519b230c0a4d8d8e28294c11816fef8a3::suimming {
    struct SUIMMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMING>(arg0, 6, b"SUIMMING", b"suimmingdog", b"top notch suimmer in the blue sea and the blue chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_E611_A9_B_7269_48_D1_9_ACF_1_AB_93988_B637_9f9531c5af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMING>>(v1);
    }

    // decompiled from Move bytecode v6
}

