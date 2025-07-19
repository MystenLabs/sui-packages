module 0xe704c948a839edd0b17a25e8b1017d6da7f4d0285e48c3d783157d1e96bbf425::snui {
    struct SNUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNUI>(arg0, 6, b"SNUI", b"Snui", b"The Chillest Meme Coin on Suai!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Xalkopedi_ston_Diastima_1_4c7fce1497.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

