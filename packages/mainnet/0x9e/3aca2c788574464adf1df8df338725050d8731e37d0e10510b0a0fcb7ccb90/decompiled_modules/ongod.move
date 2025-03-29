module 0x9e3aca2c788574464adf1df8df338725050d8731e37d0e10510b0a0fcb7ccb90::ongod {
    struct ONGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONGOD>(arg0, 9, b"ONGOD", b"On god", b"Buy this to get blessed today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f2df9afc9b992b9d4e07e976c2a21ff9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

