module 0x82b031a2b71be33af5f9d6e6da37511b32d35b8b5da10ad0959a4ab23763b546::crytpo {
    struct CRYTPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYTPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYTPO>(arg0, 9, b"CRYTPO", b"SOUL", b"Lo beli gua kaya mwehe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/150100c7-eb6d-435e-8575-a83e37100e2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYTPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYTPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

