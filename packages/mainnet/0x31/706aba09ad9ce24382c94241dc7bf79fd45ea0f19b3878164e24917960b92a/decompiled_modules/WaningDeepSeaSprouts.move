module 0x31706aba09ad9ce24382c94241dc7bf79fd45ea0f19b3878164e24917960b92a::WaningDeepSeaSprouts {
    struct WANINGDEEPSEASPROUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANINGDEEPSEASPROUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANINGDEEPSEASPROUTS>(arg0, 0, b"COS", b"Waning Deep-Sea Sprouts", b"Shriveled with the decay of a signal, lost.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Waning_Deep-Sea_Sprouts.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WANINGDEEPSEASPROUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANINGDEEPSEASPROUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

