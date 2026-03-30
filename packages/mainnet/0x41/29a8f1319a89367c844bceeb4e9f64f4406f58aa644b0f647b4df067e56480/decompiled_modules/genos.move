module 0x4129a8f1319a89367c844bceeb4e9f64f4406f58aa644b0f647b4df067e56480::genos {
    struct GENOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENOS>(arg0, 6, b"GENOS", b"Token Name", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

