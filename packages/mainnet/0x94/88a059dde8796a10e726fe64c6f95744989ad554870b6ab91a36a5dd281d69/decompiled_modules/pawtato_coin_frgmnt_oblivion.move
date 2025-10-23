module 0x9488a059dde8796a10e726fe64c6f95744989ad554870b6ab91a36a5dd281d69::pawtato_coin_frgmnt_oblivion {
    struct PAWTATO_COIN_FRGMNT_OBLIVION has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_OBLIVION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_OBLIVION>(arg0, 9, b"FRGMT_OBLIVION", b"Pawtato Fragment of Oblivion", b"Dark and still, it hums with quiet destruction. All things that begin must end - this shard carries that truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-oblivion.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_OBLIVION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_OBLIVION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

