module 0x569ec0da93920e5def06c3707ebb71160e76e2ee8bd95e8e96540966e4564371::vina {
    struct VINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINA>(arg0, 9, b"VINA", b"Malvina ", x"507265747479206769726c20776974682073656e7365f09f94a5e29da3efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9635f593-edda-430f-9cdd-4fe211053859.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

