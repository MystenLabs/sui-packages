module 0xf8c77261ee329dd63279e842f5170441248507702c19668024714305cd858f73::bapcat {
    struct BAPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPCAT>(arg0, 6, b"BAPCAT", b"Cat the Baptist", b"By the power vested in me I shall proclaim you as my loyal servant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1386_09791ba41d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

