module 0x36c84cebc796942d72831e8bb48616c905f139b29ba2a7a51486d68fdb44953a::zmbs {
    struct ZMBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMBS>(arg0, 9, b"ZMBS", b"ZOMBIES", b"ZOMBIES ARE NEAR !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21df9492-e5f2-4a9e-bdac-f8e2cb2a4321.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZMBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

