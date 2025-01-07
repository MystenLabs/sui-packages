module 0x4efa670bad0a23af16ff62ce1b00e331616d856019aa9e3e16bf729d6c58f77a::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"Cat", x"434154f09f90b120697320612063617420746f6b656e2064657369676e656420666f72207468652053756920636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eff00d6d-738e-4202-8a0e-65e963e3ce79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

