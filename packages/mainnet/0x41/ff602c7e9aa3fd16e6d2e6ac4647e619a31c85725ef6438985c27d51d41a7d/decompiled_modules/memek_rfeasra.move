module 0x41ff602c7e9aa3fd16e6d2e6ac4647e619a31c85725ef6438985c27d51d41a7d::memek_rfeasra {
    struct MEMEK_RFEASRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRA>(arg0, 6, b"MEMEKRFEASRA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

