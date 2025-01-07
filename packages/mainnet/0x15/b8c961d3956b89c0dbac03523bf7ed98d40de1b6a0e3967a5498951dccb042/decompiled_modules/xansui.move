module 0x15b8c961d3956b89c0dbac03523bf7ed98d40de1b6a0e3967a5498951dccb042::xansui {
    struct XANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XANSUI>(arg0, 6, b"XANSUI", b"XAN SUI", b"XAN SUI PIE XUE HUA PIAO PIAO BEI FENG XIAO XIAO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_16_80b668642c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

