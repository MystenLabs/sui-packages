module 0xbfd1b7da8445ba204ca6c8aef9413fba2fc637ebd61dacba986a9646122df6ef::tiker {
    struct TIKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKER>(arg0, 9, b"TIKER", b"Urina", b"That's will shoot for sure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/818ede29-e7ab-4d59-9c62-dae51ba630b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

