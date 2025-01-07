module 0xcf367fe4a9def5ed925fc8f9827752cfae7bd18bf1c47e562ce7e4711b165214::sleppy {
    struct SLEPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEPPY>(arg0, 6, b"SLEPPY", b"SLEPPYzzz", b"sleppers on the sui chain holding 4ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/edfc0cdc_2cf7_4f15_91c2_bbc9513ce998_7d86257b64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

