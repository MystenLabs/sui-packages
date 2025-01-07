module 0x41e991b25179b4adb01e3b398ecd05954641fb8e856330a662066efa7916da01::suipy {
    struct SUIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPY>(arg0, 6, b"SUIPY", b"SuipyBara", b"Funniest CapyBara On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capybara_6d19886a53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

