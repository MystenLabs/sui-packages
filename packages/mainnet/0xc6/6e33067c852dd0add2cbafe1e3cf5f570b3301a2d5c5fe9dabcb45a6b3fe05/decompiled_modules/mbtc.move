module 0xc66e33067c852dd0add2cbafe1e3cf5f570b3301a2d5c5fe9dabcb45a6b3fe05::mbtc {
    struct MBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBTC>(arg0, 9, b"mBTC", b"mBTC", b"Metastable BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/mbtc.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

