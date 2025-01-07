module 0x48dfdee8a7e3288c40d294ce8edd40901ea2ab0b199b0b473980c7b5dbac766e::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 9, b"MABA", b"MABAaa", b"Make America Based Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b76a1fa-86a1-46f0-91e1-41079167f42b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

