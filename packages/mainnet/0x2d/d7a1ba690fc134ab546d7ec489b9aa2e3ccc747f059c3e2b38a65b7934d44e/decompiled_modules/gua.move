module 0x2dd7a1ba690fc134ab546d7ec489b9aa2e3ccc747f059c3e2b38a65b7934d44e::gua {
    struct GUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUA>(arg0, 6, b"GUA", b"GUA ON SUI", b"Guaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731608344818.5499759")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

