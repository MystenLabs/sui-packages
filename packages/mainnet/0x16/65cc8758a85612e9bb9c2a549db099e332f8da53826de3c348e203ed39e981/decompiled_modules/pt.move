module 0x1665cc8758a85612e9bb9c2a549db099e332f8da53826de3c348e203ed39e981::pt {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 9, b"PT", b"Putin", x"507574696e20c491e1baa16920c491e1babf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6abaffc-ba1c-46c1-8633-45608bdded20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
    }

    // decompiled from Move bytecode v6
}

