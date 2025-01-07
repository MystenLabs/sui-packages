module 0x68381816d18ae1037df1f4a346312c0c5a38069bfffda570713534e314670539::riga {
    struct RIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGA>(arg0, 6, b"RIGA", b"RIP GARY", b"RIP GARY GENSLER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949499687.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

