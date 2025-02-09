module 0x413a5f4fcf61acac38c3da914152d58bb1c2199b67cc49203ecd564f10a2ef51::elonsui {
    struct ELONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELONSUI>(arg0, 6, b"ELONSUI", b"OFFICIAL ELON by SuiAI", b"The only OFFICIAL ELON by SUIAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/41i_PTG_9h_UOL_AC_UF_1000_1000_QL_80_69e38d5322.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELONSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

