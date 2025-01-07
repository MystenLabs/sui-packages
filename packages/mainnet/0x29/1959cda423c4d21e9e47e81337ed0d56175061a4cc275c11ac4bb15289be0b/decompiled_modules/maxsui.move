module 0x291959cda423c4d21e9e47e81337ed0d56175061a4cc275c11ac4bb15289be0b::maxsui {
    struct MAXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXSUI>(arg0, 6, b"MAXSUI", b"MAX BEAR FOR SUI", b"$MAXSUI is a meme coin with no intrinsic value. The price may go up and down which we have no control over. Do your own research before investing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_15_47b8bf9f1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

