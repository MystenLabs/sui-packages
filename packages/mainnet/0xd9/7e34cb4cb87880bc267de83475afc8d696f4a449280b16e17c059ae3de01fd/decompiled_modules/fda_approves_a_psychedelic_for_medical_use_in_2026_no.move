module 0xd97e34cb4cb87880bc267de83475afc8d696f4a449280b16e17c059ae3de01fd::fda_approves_a_psychedelic_for_medical_use_in_2026_no {
    struct FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026_NO>(arg0, 0, b"FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026_NO", b"FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026 NO", b"FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDA_APPROVES_A_PSYCHEDELIC_FOR_MEDICAL_USE_IN_2026_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

