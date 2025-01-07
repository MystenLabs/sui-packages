module 0x5941dccffab44a14fc158273fab0f2776d8224bcbac699a829c8e90d9ee2997d::chase {
    struct CHASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHASE>(arg0, 6, b"Chase", b"Chase on Sui", x"4a75737420416e6f7468657220446f6773204d656d6520546f6b656e2c20696e20537569202e2e2e20200a4974277320757020746f2074686520636f6d6d756e69747920686f7720746f20696e6372656173652056616c7565206f66207468697320746f6b656e202e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_eef48e58a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

