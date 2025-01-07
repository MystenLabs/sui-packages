module 0xfd8b59e6e36d9b35f98dd01b01654fe8622870facbdebb668e394cabbe82bcad::dexter {
    struct DEXTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEXTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEXTER>(arg0, 9, b"DEXTER", b"Waweee", b"Dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ec7e0a3-be4b-45a8-80f9-4a22848c9741.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEXTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

