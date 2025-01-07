module 0x86a3380c034d01ff559b3c61a8872c92d6135c9207938476c9a304f54a2e4857::bingus {
    struct BINGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGUS>(arg0, 6, b"BINGUS", b"BINGUStoken", b"Bald And Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_M_Ft_Jg_Pn_400x400_effe70439b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

