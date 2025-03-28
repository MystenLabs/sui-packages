module 0x5d4233f3f91a072623eeccd6c006ecaa7569710c0a68ac1caa092d2217c3df51::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 9, b"LBTC-SUI- Vault LPT", b"LBTC-SUI- Haedal Vault LP Token", b"Haedal Vault LP Token, LBTC-SUI- Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/-CIyJycPqRHU1xnI0eJLtccVFr3PJDX_Ahz7Mlh8Pvo")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

