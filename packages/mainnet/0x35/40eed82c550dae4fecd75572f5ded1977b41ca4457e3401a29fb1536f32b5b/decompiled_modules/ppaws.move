module 0x3540eed82c550dae4fecd75572f5ded1977b41ca4457e3401a29fb1536f32b5b::ppaws {
    struct PPAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPAWS>(arg0, 9, b"PPAWS", b"PAWS$", b"Paws token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26f0ecaa-13ca-4b9c-8bd7-1c6b24e51ed0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

