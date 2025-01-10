module 0x69ae66a2d0aa51a4e988022e750e5bc706d5a57d8e088c10e67b03d0e5a8ea02::addict {
    struct ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDICT>(arg0, 6, b"ADDICT", b"SUI Addict", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/addict_5d5eed01bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDICT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADDICT>>(v1);
    }

    // decompiled from Move bytecode v6
}

