module 0x650838a0f84444d5c840d8928d291eda1282bbf2573eeb7d80f5ddf8d8ae495a::suipaca {
    struct SUIPACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPACA>(arg0, 6, b"SUIPACA", b"Suipaca", b"Suipaca  The meme taking over SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipaca_16331d5bba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

