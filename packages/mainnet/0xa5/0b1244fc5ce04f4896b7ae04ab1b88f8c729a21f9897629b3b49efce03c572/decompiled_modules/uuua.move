module 0xa50b1244fc5ce04f4896b7ae04ab1b88f8c729a21f9897629b3b49efce03c572::uuua {
    struct UUUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUUA>(arg0, 9, b"UUUA", b"Iiiw", b"Hgcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93152e88-f890-43bb-b608-3aff39faa400.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UUUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

