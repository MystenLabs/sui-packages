module 0x34ae4a9d5ca9395116317f01454d5f62661358bd5f731dc16e77d4cead35c04c::frai {
    struct FRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAI>(arg0, 6, b"FRAI", b"Frai", x"54686520696e74656c6c6967656e7420616e6420706f7369746976652066726f67206f662074686520776174657220626c6f636b636861696e2e20f09f90b8f09f9299", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735492331713.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

