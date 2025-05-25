module 0x36bc697c1dba827a4bf7fa3bfc9f1b0953fe09b91c4b4c103efa0b086e03d923::ysuiusdt {
    struct YSUIUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSUIUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSUIUSDT>(arg0, 6, b"ysuiUSDT-2", b"Kai Vault suiUSDT", b"Kai Vault yield-bearing suiUSDT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSUIUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSUIUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

