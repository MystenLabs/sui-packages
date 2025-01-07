module 0x78f3e8a2bb911d3cc637b5198e28cf5584af97019f9e6720df5941a02fd7729c::suibear {
    struct SUIBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAR>(arg0, 6, b"Suibear", b"Sui Bear", b"the sui bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dae45c3c_c602_4cce_85de_b5c1a80efc53_08fad7d2c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

