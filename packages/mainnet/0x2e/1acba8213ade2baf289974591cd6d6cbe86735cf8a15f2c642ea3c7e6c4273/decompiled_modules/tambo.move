module 0x2e1acba8213ade2baf289974591cd6d6cbe86735cf8a15f2c642ea3c7e6c4273::tambo {
    struct TAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMBO>(arg0, 6, b"TAMBO", b"Trump Lambo", b"TRUMP LAMBO IS THE BEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731425728084.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

