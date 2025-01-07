module 0x8a784a8b8df0b2bfc27c293e1cf880fae90b4c770837b72fa81fc1d41f821fd3::papi {
    struct PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPI>(arg0, 9, b"PAPI", b"Papi", b"PAPI SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab4bcd4f-753c-4dca-a178-5d2cd045a221.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

