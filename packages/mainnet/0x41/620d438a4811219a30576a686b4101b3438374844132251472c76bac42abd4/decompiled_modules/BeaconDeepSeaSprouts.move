module 0x41620d438a4811219a30576a686b4101b3438374844132251472c76bac42abd4::BeaconDeepSeaSprouts {
    struct BEACONDEEPSEASPROUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEACONDEEPSEASPROUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEACONDEEPSEASPROUTS>(arg0, 0, b"COS", b"Beacon Deep-Sea Sprouts", b"The aquatic moss will guide you... if only you let it...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Beacon_Deep-Sea_Sprouts.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEACONDEEPSEASPROUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEACONDEEPSEASPROUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

