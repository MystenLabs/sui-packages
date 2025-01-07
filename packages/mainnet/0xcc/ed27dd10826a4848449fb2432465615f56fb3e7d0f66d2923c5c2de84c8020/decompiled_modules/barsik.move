module 0xcced27dd10826a4848449fb2432465615f56fb3e7d0f66d2923c5c2de84c8020::barsik {
    struct BARSIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARSIK>(arg0, 6, b"BARSIK", b"Hasbulla's Cat", x"496e206d656d6f7279206f662048617362756c6c61e28099732063757465206361742042415253494b2e204c6976696e6720666f726576657220696e2074686520536f6c616e6120626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731786165669.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARSIK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARSIK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

