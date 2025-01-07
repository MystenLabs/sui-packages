module 0xc02e249e79ffe6dc390d1eea9d520db6f0db912d656157ebe4f42f3fad60121a::neirosui {
    struct NEIROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROSUI>(arg0, 6, b"NEIROSUI", b"NEIRO ON SUI", b"NEIRO on SUI is the heir apparent to dodge, the new Shiba Inu ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_201727_ca83a876ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

