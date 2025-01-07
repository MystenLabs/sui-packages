module 0x182de5e07543bb49c824bf554b73e9dd473a42711745ce02086298236786b134::jinkx {
    struct JINKX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINKX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINKX>(arg0, 6, b"JINKX", b"Jinkx the Crypto Cat", x"5468657265e28099732061206e6577207368657269666620696e20746f776e20f09f90b12074686520667574757265206f6666696369616c20537569206d6173636f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731369078942.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINKX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINKX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

