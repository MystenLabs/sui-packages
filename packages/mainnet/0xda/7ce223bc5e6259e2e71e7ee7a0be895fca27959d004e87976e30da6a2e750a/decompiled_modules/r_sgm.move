module 0xda7ce223bc5e6259e2e71e7ee7a0be895fca27959d004e87976e30da6a2e750a::r_sgm {
    struct R_SGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_SGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_SGM>(arg0, 9, b"R_SGM", b"ryan sigma", b"This is crypto friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18fabf2a-0bcd-4920-bb89-f833f73f9040.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_SGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R_SGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

