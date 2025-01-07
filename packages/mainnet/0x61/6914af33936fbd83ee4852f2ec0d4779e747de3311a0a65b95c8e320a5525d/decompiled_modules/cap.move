module 0x616914af33936fbd83ee4852f2ec0d4779e747de3311a0a65b95c8e320a5525d::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 6, b"CAP", b"CAP on SUI", x"4c6f73742065766572797468696e67207573696e67206c657665726167652c206e6f7720492073706f7420616e64206368696c6c20f09f9aabf09fa7a2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972822469.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

