module 0x8c572e183aaec9e9a3f5ae6049927c5794cde42a044ca5bd7ed09ca24fae181e::Nine_Aine {
    struct NINE_AINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINE_AINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINE_AINE>(arg0, 9, b"NINE", b"Nine Aine", b"this is a token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1894959548730929152/uEmv5kxW_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NINE_AINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINE_AINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

