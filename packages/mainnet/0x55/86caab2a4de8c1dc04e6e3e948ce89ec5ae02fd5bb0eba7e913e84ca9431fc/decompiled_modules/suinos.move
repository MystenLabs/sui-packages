module 0x5586caab2a4de8c1dc04e6e3e948ce89ec5ae02fd5bb0eba7e913e84ca9431fc::suinos {
    struct SUINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOS>(arg0, 6, b"SUINOS", b"SUITHANOS", b"the hardest choices require the strongest wills", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979363036.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

