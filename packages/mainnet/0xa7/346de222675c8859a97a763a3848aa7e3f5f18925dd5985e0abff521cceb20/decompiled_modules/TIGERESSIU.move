module 0xa7346de222675c8859a97a763a3848aa7e3f5f18925dd5985e0abff521cceb20::TIGERESSIU {
    struct TIGERESSIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERESSIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERESSIU>(arg0, 6, b"TIGERESSIU", b"TIGERESSIU", b"LFFFFGGGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/hoMnQ08.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIGERESSIU>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERESSIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGERESSIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

