module 0xc2357e02f96c5f90d69b0ab182761d6227434830987e27103678610c895271d7::pawtato_coin_frgmnt_awakening {
    struct PAWTATO_COIN_FRGMNT_AWAKENING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_AWAKENING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_AWAKENING>(arg0, 9, b"FRGMT_AWAKENING", b"Pawtato Fragment of Awakening", b"Dormant energy stirs within this fragment, waiting to be claimed. It embodies the moment a Hero realizes their true nature - not yet divine, but no longer ordinary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-awakening.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_AWAKENING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_AWAKENING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

