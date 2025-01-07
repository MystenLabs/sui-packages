module 0x324536a95f2d1d20d2222d5c7ca4f0c9d9bc0d38601922120f1d78327cca258::mugen {
    struct MUGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGEN>(arg0, 9, b"MUGEN", b"MUU GEN", b"M UU GEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b151185-b435-4b33-83e1-134d9c7de4ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

