module 0x6e2271c5504f68b9f9a1ecb580269473b55db2f66dc5424b2ed1de40b0ed4085::djtsat {
    struct DJTSAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJTSAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJTSAT>(arg0, 6, b"DJTsat", b"Trump/Satoshi", b"This project celebrates the enormous impact that Trump has had already on cryptocurrency. Can you prove that he isn't Satoshi?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993441350.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJTSAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJTSAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

