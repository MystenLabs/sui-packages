module 0xe0f5af177c16233b6173f4bc202a84c461bf2eeb2b470f62c409ef5bfb98af6::sas {
    struct SAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAS>(arg0, 9, b"SAS", b"Aras", b"IRAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8dd20b66-bf34-4aef-bf42-73977ae44b72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

