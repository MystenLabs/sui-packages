module 0x24966d703abb542f5990b94be07b559be230c1cc1fdd5e40cc427bdcc56bfbe9::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"SHARKUI", b"https://sharkui.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735934966892.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

