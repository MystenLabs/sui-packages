module 0xef968b863fbecb3cded03fb8c8886b1fc58f64bbdbb52f708dc6dd3f3e34a515::hatchi {
    struct HATCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATCHI>(arg0, 6, b"Hatchi", b"The Loyals", b"Always there for his owner, loyal even after...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734066075844.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HATCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

