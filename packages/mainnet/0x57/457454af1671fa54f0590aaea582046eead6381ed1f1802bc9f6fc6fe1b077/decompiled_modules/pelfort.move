module 0x57457454af1671fa54f0590aaea582046eead6381ed1f1802bc9f6fc6fe1b077::pelfort {
    struct PELFORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELFORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELFORT>(arg0, 6, b"PELFORT", b"Pelfort the Wolf of Sui", b"Pelfort is here to make big moves and take over Sui with the hustle of Wall Street and the bite of a blockchain alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fg_UO_0k_U_Uc_AAQ_6_R4_removebg_preview_dc3c7f542b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELFORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELFORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

