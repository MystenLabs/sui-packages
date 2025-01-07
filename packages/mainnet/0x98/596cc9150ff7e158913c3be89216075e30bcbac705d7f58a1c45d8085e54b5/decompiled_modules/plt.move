module 0x98596cc9150ff7e158913c3be89216075e30bcbac705d7f58a1c45d8085e54b5::plt {
    struct PLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLT>(arg0, 9, b"PLT", b"PLANET", b"MAGICAL PLANETS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86c21a47-0063-4828-90b7-06c2f6c9ba8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

