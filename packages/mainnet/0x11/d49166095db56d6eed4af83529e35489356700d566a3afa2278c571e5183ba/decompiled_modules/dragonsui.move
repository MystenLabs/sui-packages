module 0x11d49166095db56d6eed4af83529e35489356700d566a3afa2278c571e5183ba::dragonsui {
    struct DRAGONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRAGONSUI>(arg0, 6, b"DRAGONSUI", b"Dragon Sui", b"Dragon on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000132667_593c3f3f40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGONSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGONSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

