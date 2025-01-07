module 0xe862d635fb2661e11a92759a56d0d4a7585210b8282f864924b7c81adc4857c8::bensui {
    struct BENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENSUI>(arg0, 6, b"BENSUI", b"Benson on SUI", b"Benson Dunwoody: The iconic living gumball machine, who runs a park, Mr. Maellard's employee, 45 years old, and is also Mordecai's boss and Rigby and Pops' best friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735261891144.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

