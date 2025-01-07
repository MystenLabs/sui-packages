module 0x5d913b063a9c0c4e05b5f6ab3a4d797bf900d9735aa3c93504100fc8752cf471::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"LOVE", b"Sos", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72a73bee-2b5f-4abf-9c03-6f405a6dff67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

