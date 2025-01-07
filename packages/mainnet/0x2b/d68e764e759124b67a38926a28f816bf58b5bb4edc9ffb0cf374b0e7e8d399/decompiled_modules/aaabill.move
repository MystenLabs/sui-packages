module 0x2bd68e764e759124b67a38926a28f816bf58b5bb4edc9ffb0cf374b0e7e8d399::aaabill {
    struct AAABILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABILL>(arg0, 6, b"AAABILL", b"aaaBill", b"AAAaaaBill On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_4_44842b8119.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

