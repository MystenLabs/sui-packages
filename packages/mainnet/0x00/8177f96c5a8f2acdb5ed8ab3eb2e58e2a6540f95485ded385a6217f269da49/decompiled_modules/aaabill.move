module 0x8177f96c5a8f2acdb5ed8ab3eb2e58e2a6540f95485ded385a6217f269da49::aaabill {
    struct AAABILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABILL>(arg0, 6, b"AAABILL", b"aaaBill", b"AAAaaaBill On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_4_6932542534.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

