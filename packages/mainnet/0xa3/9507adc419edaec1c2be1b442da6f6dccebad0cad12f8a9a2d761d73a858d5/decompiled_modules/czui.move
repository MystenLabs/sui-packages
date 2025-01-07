module 0xa39507adc419edaec1c2be1b442da6f6dccebad0cad12f8a9a2d761d73a858d5::czui {
    struct CZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZUI>(arg0, 9, b"CZUI", b"ChangpengZ", b"Just got released so why don't we get this bullrun started shall we... LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc017a55-51f1-41b1-9501-8774b57b0db5-1000202513.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

