module 0x4bc3ac6862e850ad34a6f600f067d38e6621d620836163af746ca86abc9722f::rally {
    struct RALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RALLY>(arg0, 9, b"RALLY", b"CARS", x"456e65726765746963206576656e747320616e6420676174686572696e67730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bbeaf1d-d66c-4395-8fba-41b38cf57ced.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

