module 0x898b2fe43fe3df593eaca42cc479e158187ae0fde031f930da9b9110994ed1d0::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"MOON", b"Moon Boy", b" What's up! Just another Moontruther here who makes fanart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JYuxZla.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

