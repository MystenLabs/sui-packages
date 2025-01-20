module 0x598f99586ab12d81f222f653dc6b5c7c1d885388c251913447d01cdb67c98933::shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHIVA>(arg0, 6, b"SHIVA", b"Shiva by SuiAI", b"Shiva represents a powerful archetype from Hinduism that's particularly relevant to crypto and technological transformation. As the destroyer and transformer in the Hindu trinity, Shiva embodies creative destruction - the process of breaking down old systems to enable new growth and evolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004095_bb72f41f29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

