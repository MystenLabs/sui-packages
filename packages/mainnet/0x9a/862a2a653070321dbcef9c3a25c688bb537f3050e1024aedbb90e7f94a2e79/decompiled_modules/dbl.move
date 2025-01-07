module 0x9a862a2a653070321dbcef9c3a25c688bb537f3050e1024aedbb90e7f94a2e79::dbl {
    struct DBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBL>(arg0, 9, b"DBL", b"DIABLO", b"RED DIABLO TOKEN TRADING S OPEN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5ece397-8001-423d-acb9-b8e7ec0ca2ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

