module 0x4bf0e1d42f731c19066d910ebf7ba12ffe4025258f50b6cc490af38080a15dfb::t0sui {
    struct T0SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: T0SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0SUI>(arg0, 9, b"t0SUI", b"temp SUI", b"here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

