module 0xa413914cab37ff0628f90e2e08f20e31bf1b908add8ab830a20a608775676d71::grass {
    struct GRASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRASS>(arg0, 9, b"GRASS", b"Grass", x"43e1bb8f206de1bbb9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18015e20-2cc7-482b-a4ed-cd3f1319b204.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

