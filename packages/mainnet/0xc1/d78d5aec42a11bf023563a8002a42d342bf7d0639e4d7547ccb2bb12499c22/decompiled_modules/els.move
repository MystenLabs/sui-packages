module 0xc1d78d5aec42a11bf023563a8002a42d342bf7d0639e4d7547ccb2bb12499c22::els {
    struct ELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELS>(arg0, 6, b"ElS", b"Elonsui", b"Token Meme da comunidade ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730603453160.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

