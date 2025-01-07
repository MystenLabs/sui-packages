module 0x57f4331e624c22b834d1bd24b79bccf6fe5af71bad850355b34e5757fc225774::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"PUMP SUI", b"LFG WITH PUMP SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd0b6e5a160eb438d5753dbebf2a29c31af1cb13989cac55fd785cd22357c2f96_pump_pump_834827d25f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

