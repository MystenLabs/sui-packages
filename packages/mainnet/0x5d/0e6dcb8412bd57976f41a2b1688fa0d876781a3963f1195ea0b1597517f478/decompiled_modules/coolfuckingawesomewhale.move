module 0x5d0e6dcb8412bd57976f41a2b1688fa0d876781a3963f1195ea0b1597517f478::coolfuckingawesomewhale {
    struct COOLFUCKINGAWESOMEWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLFUCKINGAWESOMEWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLFUCKINGAWESOMEWHALE>(arg0, 6, b"COOLFUCKINGAWESOMEWHALE", b"COOL FUCKING AWESOME WHALE", b"Its time for everyone to swim with the big fish. This coin is made for the big players by the big players.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wha_a703f2211d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLFUCKINGAWESOMEWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLFUCKINGAWESOMEWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

