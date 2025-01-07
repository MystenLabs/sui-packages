module 0x6ea1b6e778c4a18f9a344eaadb3a61a80e32fe79e2e188ac8616acbbcb67b42a::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"BONGO CAT CTO", x"424f4e474f204341542043544f0a4a4f494e204e45572054454c454752414d0a4445582050524550414944", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_08_092452_ee880efa75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

