module 0x9534b47cc9b0aa4a2851940bddc5d94b27e8881fc252925e7e1242e29cfe19f0::mudkipsui {
    struct MUDKIPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIPSUI>(arg0, 6, b"MUDKIPSUI", b"Mudkiponsui", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994636165.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

