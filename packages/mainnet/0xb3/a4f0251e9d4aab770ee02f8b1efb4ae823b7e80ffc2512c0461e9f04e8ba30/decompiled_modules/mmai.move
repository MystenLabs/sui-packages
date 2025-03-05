module 0xb3a4f0251e9d4aab770ee02f8b1efb4ae823b7e80ffc2512c0461e9f04e8ba30::mmai {
    struct MMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMAI>(arg0, 9, b"MMAI", b"Mind Menders AI", b"Mind Menders AI is crypto agant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4ab4821c34fc8543a05dc048244e0548blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

