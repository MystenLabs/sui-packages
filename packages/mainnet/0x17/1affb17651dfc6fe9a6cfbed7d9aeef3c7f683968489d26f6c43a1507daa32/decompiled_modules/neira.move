module 0x171affb17651dfc6fe9a6cfbed7d9aeef3c7f683968489d26f6c43a1507daa32::neira {
    struct NEIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRA>(arg0, 6, b"NEIRA", b"NEIRA SUI", b"Sister of Neiro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xdxdxddx_23f378adf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

