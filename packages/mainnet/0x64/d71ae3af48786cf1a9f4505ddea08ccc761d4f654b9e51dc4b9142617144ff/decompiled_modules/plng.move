module 0x64d71ae3af48786cf1a9f4505ddea08ccc761d4f654b9e51dc4b9142617144ff::plng {
    struct PLNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLNG>(arg0, 9, b"PLNG", b"PALANGI", b"WAITING FOR PALANG DUFFS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db164d9a-0e1c-4fee-b505-57e207deed58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

