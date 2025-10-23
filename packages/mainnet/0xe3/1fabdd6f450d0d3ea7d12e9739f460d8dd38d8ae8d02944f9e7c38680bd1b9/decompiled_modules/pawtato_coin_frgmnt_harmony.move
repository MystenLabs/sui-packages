module 0xe31fabdd6f450d0d3ea7d12e9739f460d8dd38d8ae8d02944f9e7c38680bd1b9::pawtato_coin_frgmnt_harmony {
    struct PAWTATO_COIN_FRGMNT_HARMONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_HARMONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_HARMONY>(arg0, 9, b"FRGMT_HARMONY", b"Pawtato Fragment of Harmony", b"A pulse of balance hums within - between body and spirit, earth and sky. Heroes carrying it walk in perfect rhythm with the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-harmony.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_HARMONY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_HARMONY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

