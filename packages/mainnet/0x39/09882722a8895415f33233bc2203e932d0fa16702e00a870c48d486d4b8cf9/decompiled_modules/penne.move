module 0x3909882722a8895415f33233bc2203e932d0fa16702e00a870c48d486d4b8cf9::penne {
    struct PENNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENNE>(arg0, 9, b"PENNE", b"jend", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7df40fa6-0f66-44e0-996b-f931b979e22e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

