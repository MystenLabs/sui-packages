module 0x93a3a08a201dc921dfbb50f19a372567d519069f679363369c72dff8219100d1::gpm {
    struct GPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPM>(arg0, 9, b"GPM", b"gpmgpm", b"GPMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25106704-62fa-47af-9961-6818e459f546.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

