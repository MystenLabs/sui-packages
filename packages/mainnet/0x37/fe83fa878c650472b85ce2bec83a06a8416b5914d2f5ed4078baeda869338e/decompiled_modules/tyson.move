module 0x37fe83fa878c650472b85ce2bec83a06a8416b5914d2f5ed4078baeda869338e::tyson {
    struct TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSON>(arg0, 6, b"TYSON", b"Mike Tyson", b"Iron Mike - The Come back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731351723678.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

