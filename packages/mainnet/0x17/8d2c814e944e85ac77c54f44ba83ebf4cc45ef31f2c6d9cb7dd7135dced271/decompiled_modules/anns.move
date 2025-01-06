module 0x178d2c814e944e85ac77c54f44ba83ebf4cc45ef31f2c6d9cb7dd7135dced271::anns {
    struct ANNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANNS>(arg0, 9, b"ANNS", b"annaclothi", b"ANNAXCFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/829fd7f8-be34-4bb2-a425-4c670d7d94ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

