module 0xf498e0fbfba6f26847f9b9c7a4e57ea875c7571062a1e735b06c164e3774c211::rib {
    struct RIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIB>(arg0, 6, b"Rib", b"McRib", b"The famous McRib sandwich. Get McRibbed while you can. Wonderful historical correlation with BTC price, so get in before we pump to $100k per token. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732243984173.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

