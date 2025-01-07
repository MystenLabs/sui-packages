module 0x5c0e186017d912f60ac74760217561cb750fc69179cf2135867a83e8fdb54e9a::aaabill {
    struct AAABILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABILL>(arg0, 6, b"aaaBILL", b"AAABILL", b"AAAaaaBill On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_4_2b2399d230.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

