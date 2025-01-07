module 0x15e89fb27fef01c406a616be9a0b2fd5da1c146e5c7951d6e05582c01f1d9ec8::suyan {
    struct SUYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUYAN>(arg0, 6, b"SUYAN", b"SUPERSUYAN", b"So the supercycle is finally happening huh?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957744764.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

