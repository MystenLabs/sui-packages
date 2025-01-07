module 0x2fc8a9ea670348a75ae163cab90fbf339b6a4b9113ffaf554699cfba287dd499::etf {
    struct ETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETF>(arg0, 6, b"ETF", b"SUI ETF", b"Every TradeS fUCKED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/redbull_97e4ba32c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETF>>(v1);
    }

    // decompiled from Move bytecode v6
}

