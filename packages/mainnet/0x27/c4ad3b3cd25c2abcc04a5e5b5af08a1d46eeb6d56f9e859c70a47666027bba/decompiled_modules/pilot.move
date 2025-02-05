module 0x27c4ad3b3cd25c2abcc04a5e5b5af08a1d46eeb6d56f9e859c70a47666027bba::pilot {
    struct PILOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PILOT>(arg0, 6, b"PILOT", b"Pilot by SuiAI", b"PilotPilotPilot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_28_at_8_29_23_PM_e54b1e6be4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PILOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

