module 0x932cfb944f13a1ad9d09e3763b75f2f44bd182479a41506b31a5dc07bcd1e3a6::bailey {
    struct BAILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAILEY>(arg0, 6, b"BAILEY", b"BAILEY SUI", b"Baileys been making quiet moves, and the impact is about to be huge. When someone like that steps in, you know something big is about to unfold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bayle_05d9f91565.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAILEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

