module 0x4bf8e2508ef833a2deb08d92e5c349f9146c2fd8e026d8e3cfa9cb1193707cc0::camel {
    struct CAMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMEL>(arg0, 6, b"CAMEL", b"Sui Camel", b"Just a Camel in Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003411447.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAMEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

