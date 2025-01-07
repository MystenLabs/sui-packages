module 0xc9d65ed7a12ea608fabf3eb70813cb61bb64f3ee2d813cbd30805a8eff7520a2::aasd2 {
    struct AASD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AASD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AASD2>(arg0, 9, b"AASD2", b"david", x"617373c49171", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8d740ed-ce23-4620-8fad-a34ad64dee37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASD2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AASD2>>(v1);
    }

    // decompiled from Move bytecode v6
}

