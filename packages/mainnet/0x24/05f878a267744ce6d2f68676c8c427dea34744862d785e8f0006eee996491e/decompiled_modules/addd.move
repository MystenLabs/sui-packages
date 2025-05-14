module 0x2405f878a267744ce6d2f68676c8c427dea34744862d785e8f0006eee996491e::addd {
    struct ADDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADDD>(arg0, 6, b"ADDD", b"AD testt", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.daosui.fun/uploads/cell_79729ac20c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADDD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

