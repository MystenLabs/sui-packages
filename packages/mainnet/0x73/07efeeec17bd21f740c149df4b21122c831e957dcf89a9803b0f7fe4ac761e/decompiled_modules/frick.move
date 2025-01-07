module 0x7307efeeec17bd21f740c149df4b21122c831e957dcf89a9803b0f7fe4ac761e::frick {
    struct FRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRICK>(arg0, 9, b"FRICK", b"ImNotFrick", b"For not fricks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af242dd1-b27d-49a9-be7e-b521b3254e47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

