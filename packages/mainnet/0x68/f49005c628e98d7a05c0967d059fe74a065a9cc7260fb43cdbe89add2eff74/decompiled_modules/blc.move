module 0x68f49005c628e98d7a05c0967d059fe74a065a9cc7260fb43cdbe89add2eff74::blc {
    struct BLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLC>(arg0, 6, b"BLC", b"Bluecoin", b"https://t.me/BitcoinxSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745859784019.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

