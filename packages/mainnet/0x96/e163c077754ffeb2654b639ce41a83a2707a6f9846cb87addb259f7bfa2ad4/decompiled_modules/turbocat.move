module 0x96e163c077754ffeb2654b639ce41a83a2707a6f9846cb87addb259f7bfa2ad4::turbocat {
    struct TURBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOCAT>(arg0, 6, b"TURBOCAT", b"Turbocat", b"Hi, I'm Turbo, the coolest cat on sui! I am the first Cat to get that B... in Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991373720.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

