module 0xae095a0a59826f9d9af324b76b61102d13a1d756cdb8dfa3f8a40a68ed5bc007::dado {
    struct DADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADO>(arg0, 9, b"DADO", b"Dadoo", b"Dado ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/316202f3-25bc-4b2d-b465-a10b07e6cfad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

