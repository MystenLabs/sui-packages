module 0x18a783f106eddb59ebb7c251241c6040bd3a55c71c5098639dfced340a97b6c7::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORO>(arg0, 6, b"TORO", b"TOR0 ON SUI", b"Trust in $TORO, save your $SUI, and ride into the eternal Bull the Market! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bpex_Li_Ukck_Z5_G8_JUCB_47vu3_G6_Pdwckcw_HC_Hn_Veju_WPSB_d606647f3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

