module 0x4de06d3cd616b74295191ff3a979b219f89b4e1a9ff2bed4eea8ff1042dccdce::nnene {
    struct NNENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNENE>(arg0, 9, b"NNENE", b"Nene", b"NNN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/7df8eecd-2951-4562-8974-39590cbc9a18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

