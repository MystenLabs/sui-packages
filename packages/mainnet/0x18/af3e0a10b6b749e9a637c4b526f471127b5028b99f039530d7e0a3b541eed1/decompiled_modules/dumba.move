module 0x18af3e0a10b6b749e9a637c4b526f471127b5028b99f039530d7e0a3b541eed1::dumba {
    struct DUMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBA>(arg0, 6, b"DUMBA", b"DUMB AGENT", b"Just a dumb agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736440172024.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

