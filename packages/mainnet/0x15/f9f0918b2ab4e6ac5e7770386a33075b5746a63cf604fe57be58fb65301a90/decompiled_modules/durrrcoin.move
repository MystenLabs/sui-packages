module 0x15f9f0918b2ab4e6ac5e7770386a33075b5746a63cf604fe57be58fb65301a90::durrrcoin {
    struct DURRRCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DURRRCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DURRRCOIN>(arg0, 6, b"DURRRCOIN", b"Mr. Durrr by SuiAI", b"Mr. Durrr is just trying to get by.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/durrr_beac9b558d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DURRRCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DURRRCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

