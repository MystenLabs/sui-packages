module 0xc69f3b7cb4f41915418416aa516fba610fcaa6805fa115119ddc70423efe8f14::los {
    struct LOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOS>(arg0, 9, b"LOS", b"LoopOnSui", b"This cooin create only fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86efa193-1d55-4205-b485-747bad288620.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

