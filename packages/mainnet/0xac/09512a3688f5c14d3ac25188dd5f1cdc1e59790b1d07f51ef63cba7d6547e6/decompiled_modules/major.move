module 0xac09512a3688f5c14d3ac25188dd5f1cdc1e59790b1d07f51ef63cba7d6547e6::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAJOR>(arg0, 6, b"MAJOR", b"MAJOR ON SUI", b"$MAJOR is the next big frog on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_d25f1742aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAJOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

