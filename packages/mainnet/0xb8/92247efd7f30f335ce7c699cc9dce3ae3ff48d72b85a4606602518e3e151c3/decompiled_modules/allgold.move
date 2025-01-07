module 0xb892247efd7f30f335ce7c699cc9dce3ae3ff48d72b85a4606602518e3e151c3::allgold {
    struct ALLGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLGOLD>(arg0, 6, b"ALLGOLD", b"ALLIEN GOLD", b"TOKEN DE PROGRESSO MUNDIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731085788031.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLGOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLGOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

