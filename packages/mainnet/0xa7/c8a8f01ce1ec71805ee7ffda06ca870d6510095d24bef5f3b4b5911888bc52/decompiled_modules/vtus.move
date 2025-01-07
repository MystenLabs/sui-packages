module 0xa7c8a8f01ce1ec71805ee7ffda06ca870d6510095d24bef5f3b4b5911888bc52::vtus {
    struct VTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTUS>(arg0, 9, b"VTUS", b"Supertus", b"Vtus1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8dced3a-9513-451b-84be-3d12daa1e401.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

