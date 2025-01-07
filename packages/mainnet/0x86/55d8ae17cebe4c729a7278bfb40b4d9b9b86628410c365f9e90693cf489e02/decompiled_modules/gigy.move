module 0x8655d8ae17cebe4c729a7278bfb40b4d9b9b86628410c365f9e90693cf489e02::gigy {
    struct GIGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGY>(arg0, 9, b"GIGY", b"GYM", b"GILIGYMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19239b71-eac6-459b-b278-618e34446242.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

