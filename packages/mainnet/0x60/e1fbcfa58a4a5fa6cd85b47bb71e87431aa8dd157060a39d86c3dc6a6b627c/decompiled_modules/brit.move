module 0x60e1fbcfa58a4a5fa6cd85b47bb71e87431aa8dd157060a39d86c3dc6a6b627c::brit {
    struct BRIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIT>(arg0, 6, b"BRIT", b"British Fish", b"OYE MATE. I'M A FRICKIN FISH, INNIT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/british_fish_dfc722df33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

