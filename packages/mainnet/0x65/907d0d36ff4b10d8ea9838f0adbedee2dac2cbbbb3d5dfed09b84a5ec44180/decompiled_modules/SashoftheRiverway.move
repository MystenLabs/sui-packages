module 0x65907d0d36ff4b10d8ea9838f0adbedee2dac2cbbbb3d5dfed09b84a5ec44180::SashoftheRiverway {
    struct SASHOFTHERIVERWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHERIVERWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHERIVERWAY>(arg0, 0, b"COS", b"Sash of the Riverway", b"Left behind on a Ward's crown...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Riverway.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHERIVERWAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHERIVERWAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

