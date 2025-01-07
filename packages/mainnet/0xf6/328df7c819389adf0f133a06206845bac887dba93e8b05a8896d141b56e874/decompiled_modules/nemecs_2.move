module 0xf6328df7c819389adf0f133a06206845bac887dba93e8b05a8896d141b56e874::nemecs_2 {
    struct NEMECS_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMECS_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMECS_2>(arg0, 9, b"NEMECS_2", b"Nemecs2", b"For fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/700f9d78-b611-417f-83bd-bdd99e56f3b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMECS_2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMECS_2>>(v1);
    }

    // decompiled from Move bytecode v6
}

