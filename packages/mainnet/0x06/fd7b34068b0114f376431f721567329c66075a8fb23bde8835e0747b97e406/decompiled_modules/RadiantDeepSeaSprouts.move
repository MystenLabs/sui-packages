module 0x6fd7b34068b0114f376431f721567329c66075a8fb23bde8835e0747b97e406::RadiantDeepSeaSprouts {
    struct RADIANTDEEPSEASPROUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADIANTDEEPSEASPROUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADIANTDEEPSEASPROUTS>(arg0, 0, b"COS", b"Radiant Deep-Sea Sprouts", b"Gravity puddles and flips... entropy unraveled...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Radiant_Deep-Sea_Sprouts.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RADIANTDEEPSEASPROUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADIANTDEEPSEASPROUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

