module 0x74aca64101da915ec385a1d4835094feec5b7d6675295d5198a7699e09fd15e9::fcjkbsfgjm {
    struct FCJKBSFGJM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCJKBSFGJM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCJKBSFGJM>(arg0, 9, b"FCJKBSFGJM", b"Fhncdf", b"Cnkkddehjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01ad2480-269a-44eb-8731-4f507fb22d19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCJKBSFGJM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCJKBSFGJM>>(v1);
    }

    // decompiled from Move bytecode v6
}

