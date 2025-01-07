module 0xb7bc63ad0cde567fa6e7c4589332513a3b0df3c29e282b011f7532a65bbc1ba5::dgu_btc {
    struct DGU_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGU_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGU_BTC>(arg0, 6, b"dguBTC", b"dguBTC", b"dguBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/6fbea0356edd48a4a68a4b877195443c.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGU_BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGU_BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

