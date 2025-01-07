module 0x68013840ff2ad5bb2420e22c5079cb27a13fb0fcff95b7da8b5a282aaf679d4e::vanco {
    struct VANCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANCO>(arg0, 9, b"VANCO", b"Vincent", b"vangog coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/220a608e-0c53-4026-81dd-986204b55a32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

