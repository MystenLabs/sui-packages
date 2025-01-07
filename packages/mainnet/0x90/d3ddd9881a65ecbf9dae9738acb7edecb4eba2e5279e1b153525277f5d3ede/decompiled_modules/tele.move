module 0x90d3ddd9881a65ecbf9dae9738acb7edecb4eba2e5279e1b153525277f5d3ede::tele {
    struct TELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELE>(arg0, 9, b"TELE", b"Telemite", b"This project is Backed by BlNANCE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/008eb376-0154-41fb-9e29-ddb1622d641a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

