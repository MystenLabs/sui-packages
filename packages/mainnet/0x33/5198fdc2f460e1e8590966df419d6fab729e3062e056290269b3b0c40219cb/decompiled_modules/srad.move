module 0x335198fdc2f460e1e8590966df419d6fab729e3062e056290269b3b0c40219cb::srad {
    struct SRAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRAD>(arg0, 9, b"SRAD", b"Sr", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd586538-97fa-4a4c-aa9b-11fb77383c64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

