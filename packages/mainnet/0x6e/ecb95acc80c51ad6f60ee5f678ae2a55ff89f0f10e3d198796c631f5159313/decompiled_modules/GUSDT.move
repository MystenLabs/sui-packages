module 0x6eecb95acc80c51ad6f60ee5f678ae2a55ff89f0f10e3d198796c631f5159313::GUSDT {
    struct GUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSDT>(arg0, 9, b"GUSDT", b"GUSDT", b"GUSDT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUSDT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

