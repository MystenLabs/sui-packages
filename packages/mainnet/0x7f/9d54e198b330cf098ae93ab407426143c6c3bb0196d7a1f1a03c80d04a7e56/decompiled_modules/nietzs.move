module 0x7f9d54e198b330cf098ae93ab407426143c6c3bb0196d7a1f1a03c80d04a7e56::nietzs {
    struct NIETZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIETZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIETZS>(arg0, 9, b"NIETZS", b"nietzsche", b"Friedric nietzsche", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7d258c3-7a6c-475e-ac15-e7d9aefea72e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIETZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIETZS>>(v1);
    }

    // decompiled from Move bytecode v6
}

