module 0xe8691e750f45915f32afa0862b5532184c6639954433614e469163636c5d2294::cr {
    struct CR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR>(arg0, 9, b"CR", b"Car", b"Create eco-friendly car", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d17e2d52-2a8b-483b-9a98-2e6ea2535c15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR>>(v1);
    }

    // decompiled from Move bytecode v6
}

