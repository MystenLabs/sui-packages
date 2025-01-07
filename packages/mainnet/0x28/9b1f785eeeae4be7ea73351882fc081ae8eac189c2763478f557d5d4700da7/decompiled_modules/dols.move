module 0x289b1f785eeeae4be7ea73351882fc081ae8eac189c2763478f557d5d4700da7::dols {
    struct DOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLS>(arg0, 9, b"DOLS", b"Dolls", b"Dolls community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9902380e-1e8d-4f7f-9670-98ddf34d0e62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

