module 0x223b049e5d1d24ea6b2f10167f8c89f069b5005121c8a68b9f7d168b14383b16::nthng {
    struct NTHNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTHNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTHNG>(arg0, 9, b"NTHNG", b"Nothing", b"pr nthng? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17268f23-0eec-4474-9898-562b2035b4bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTHNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTHNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

