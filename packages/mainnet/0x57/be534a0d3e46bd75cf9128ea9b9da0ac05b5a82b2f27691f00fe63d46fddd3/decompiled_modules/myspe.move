module 0x57be534a0d3e46bd75cf9128ea9b9da0ac05b5a82b2f27691f00fe63d46fddd3::myspe {
    struct MYSPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSPE>(arg0, 6, b"MYSPE", b"Mystic Pepe", x"546865204d797374696320506570652c2074686520656e69676d617469632066696e616c20626f7373206f66204d617474204675726965277320e2809c54686520426f797320436c7562e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731516625365.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

