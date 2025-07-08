module 0x1ff458ff7555a5a1fcd38f601e32f34154c6fbd01130d45150f5768059e89cb2::froggie {
    struct FROGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGIE>(arg0, 6, b"Froggie", b"froggie", b"Froggie HAHAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751966099757.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGGIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

