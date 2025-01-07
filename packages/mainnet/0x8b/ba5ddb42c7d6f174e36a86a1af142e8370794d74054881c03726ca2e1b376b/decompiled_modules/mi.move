module 0x8bba5ddb42c7d6f174e36a86a1af142e8370794d74054881c03726ca2e1b376b::mi {
    struct MI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MI>(arg0, 6, b"MI", x"44c3a176696420472e", b"LEIRAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9xg_V_Rb3_P_400x400_27c287dd7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

