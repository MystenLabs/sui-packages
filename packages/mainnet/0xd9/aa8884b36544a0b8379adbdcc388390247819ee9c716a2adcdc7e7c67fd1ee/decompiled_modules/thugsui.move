module 0xd9aa8884b36544a0b8379adbdcc388390247819ee9c716a2adcdc7e7c67fd1ee::thugsui {
    struct THUGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUGSUI>(arg0, 6, b"ThugSui", b"Sui Thug Pugs", b"Even pugs like to have fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732191236803.50")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THUGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

