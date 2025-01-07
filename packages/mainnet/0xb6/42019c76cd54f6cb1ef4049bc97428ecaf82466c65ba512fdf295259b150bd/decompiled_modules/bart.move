module 0xb642019c76cd54f6cb1ef4049bc97428ecaf82466c65ba512fdf295259b150bd::bart {
    struct BART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BART>(arg0, 6, b"BART", b"Bart Suimpson", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies congue ipsum, sit amet venenatis ligula vestibulum sollicitudin. Donec vel justo metus. Nullam vel lectus pulvinar, luctus lorem vel, aliquet arcu. Vestibulum eget luctus risus. Curabitur eget sollicitudin est, et posuere dui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimpson_Move_Logo_9203f7578f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BART>>(v1);
    }

    // decompiled from Move bytecode v6
}

