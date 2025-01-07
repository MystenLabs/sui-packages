module 0x61f9bcb9d87cd809de05bc09a139e464d9f90da18eb789f4b49ad5b10d57bdc1::kirk {
    struct KIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRK>(arg0, 9, b"KIRK", b"Lazarus", b"Kirk Lazarus is the goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60c2e3d5-9d44-4b4a-96f8-b0d566b07bc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

