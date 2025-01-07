module 0xe64c6ac5c4adf95a5fb41445eb47f82e9984d6adf6a8e67a2b2da5135c950e81::aaabear {
    struct AAABEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABEAR>(arg0, 6, b"aaaBear", b"aaaBEAR", b"\"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaBear, big waves \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_4_2d13c96597.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

