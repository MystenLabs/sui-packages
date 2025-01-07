module 0x80d4782c2406530ff9cc5a948b0467d5da860fea12f867eabbcb703373314cb1::fengsui {
    struct FENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGSUI>(arg0, 6, b"FENGSUI", b"Feng-Sui", b"Welcome to Feng-Sui!  Feel the harmony, balance, and positive vibes in our space! $FENGSUI https://t.me/fengsuicoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_Qrz73r8_400x400_cc3f05fedb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

