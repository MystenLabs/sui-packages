module 0x6d43a353e908af38e7eff0381a3fd88ea8437ba7a1834d8195e333cf630d92f8::sdeer {
    struct SDEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDEER>(arg0, 6, b"SDEER", b"SUIDEER", x"536e65616b696e6720696e746f204d75736b2773207265706c79206c617465206174206e696768742c20446565720a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xvy1va_XQA_Aw5q_Q_2a059ca349.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

