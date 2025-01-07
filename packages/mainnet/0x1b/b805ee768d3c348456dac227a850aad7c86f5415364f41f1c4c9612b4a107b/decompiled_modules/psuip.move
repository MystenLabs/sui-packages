module 0x1bb805ee768d3c348456dac227a850aad7c86f5415364f41f1c4c9612b4a107b::psuip {
    struct PSUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIP>(arg0, 6, b"pSUIP", b"SUI PUMP", b"COMMUNITY TAKE OVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2f14b542_f3e5_4e14_95ae_e0c9a23d4b5e_637cb5b0bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

