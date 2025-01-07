module 0x648783b982c8af7aeb84762f9db419116da01a1fb9b686216fe56dd7f5123257::suigeria {
    struct SUIGERIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGERIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGERIA>(arg0, 6, b"Suigeria", b"Suigerians", b"On a mission to get 1M new Nigerians onboarded to $SUI $SUIGERIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_b408131743.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGERIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGERIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

