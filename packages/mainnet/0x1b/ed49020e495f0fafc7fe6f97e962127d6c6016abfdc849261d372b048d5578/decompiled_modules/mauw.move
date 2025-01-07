module 0x1bed49020e495f0fafc7fe6f97e962127d6c6016abfdc849261d372b048d5578::mauw {
    struct MAUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAUW>(arg0, 6, b"MAUW", b"MASUI CAT", b"MASUI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dvdvdvdfv_072874e3ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAUW>>(v1);
    }

    // decompiled from Move bytecode v6
}

