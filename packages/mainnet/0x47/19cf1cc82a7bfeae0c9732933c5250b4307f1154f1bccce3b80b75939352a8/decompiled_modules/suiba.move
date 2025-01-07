module 0x4719cf1cc82a7bfeae0c9732933c5250b4307f1154f1bccce3b80b75939352a8::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 6, b"SUIBA", b"Sui Shiba", x"5375692773204368656170657374202620466173746573742054726164696e6720426f740a68747470733a2f2f782e636f6d2f7375696261626f745f696f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956306168.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

