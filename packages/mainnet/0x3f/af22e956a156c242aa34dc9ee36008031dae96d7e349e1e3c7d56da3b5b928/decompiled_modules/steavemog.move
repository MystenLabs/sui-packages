module 0x3faf22e956a156c242aa34dc9ee36008031dae96d7e349e1e3c7d56da3b5b928::steavemog {
    struct STEAVEMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAVEMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAVEMOG>(arg0, 6, b"STEAVEMOG", b"TERMINAL Steave Mog", b"APPLE MOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_7_e526a756f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAVEMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAVEMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

