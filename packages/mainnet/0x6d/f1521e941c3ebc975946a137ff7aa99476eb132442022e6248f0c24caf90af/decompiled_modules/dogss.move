module 0x6df1521e941c3ebc975946a137ff7aa99476eb132442022e6248f0c24caf90af::dogss {
    struct DOGSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSS>(arg0, 9, b"DOGSS", b"dogsdogs", b"Bump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14ad808e-f939-439d-b85b-71f3c00a7394.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

