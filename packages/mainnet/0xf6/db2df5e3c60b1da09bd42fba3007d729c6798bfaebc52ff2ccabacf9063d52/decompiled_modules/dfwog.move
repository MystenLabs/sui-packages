module 0xf6db2df5e3c60b1da09bd42fba3007d729c6798bfaebc52ff2ccabacf9063d52::dfwog {
    struct DFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFWOG>(arg0, 9, b"DFWOG", b"Fwog dady", b"Dady fwog is father of fwog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fe4b502-2d21-4da3-92b5-5669bbb8adae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

