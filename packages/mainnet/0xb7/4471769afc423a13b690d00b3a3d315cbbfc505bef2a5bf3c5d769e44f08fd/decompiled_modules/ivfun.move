module 0xb74471769afc423a13b690d00b3a3d315cbbfc505bef2a5bf3c5d769e44f08fd::ivfun {
    struct IVFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVFUN>(arg0, 9, b"IVFUN", b"Invest Zon", b"Just for fun and grab some", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5093dc3e-c252-4677-8ac6-891654d0be6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

