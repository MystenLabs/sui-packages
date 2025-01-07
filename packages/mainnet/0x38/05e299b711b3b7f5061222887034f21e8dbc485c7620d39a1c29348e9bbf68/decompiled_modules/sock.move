module 0x3805e299b711b3b7f5061222887034f21e8dbc485c7620d39a1c29348e9bbf68::sock {
    struct SOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCK>(arg0, 6, b"SOCK", b"SOCKSUI", b"The Sox have eyes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_1m_EEA_Xw_A4t_Ewe_737652ca27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

