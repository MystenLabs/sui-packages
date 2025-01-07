module 0xf98868ceaa43ec80319fac3513a47af8ef7eec81dd1e54eff1005bfc3fd2a28b::logitech {
    struct LOGITECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOGITECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOGITECH>(arg0, 6, b"LOGITECH", b"KOREAN BIND", b"t sur?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wir_1e663bb948.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOGITECH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOGITECH>>(v1);
    }

    // decompiled from Move bytecode v6
}

