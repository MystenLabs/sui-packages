module 0x463973238738a8d85b5035edcd5809329486614b0eee56150e7910bed0f8337::slt {
    struct SLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLT>(arg0, 9, b"SLT", b"skeleton", b"The main structure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dbc5f26-1a1a-4636-82e3-21606341f2aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

