module 0xc74afe14db676032e293e7ee1c6d9be95c416f304cc8229dbf560631b6408cb::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"QUANT", b"QUANT on SUI", b"Im truly a Gen Z $Quant kid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc1_Kc_R3_Xg_AA_3_RE_e9e60336f3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

