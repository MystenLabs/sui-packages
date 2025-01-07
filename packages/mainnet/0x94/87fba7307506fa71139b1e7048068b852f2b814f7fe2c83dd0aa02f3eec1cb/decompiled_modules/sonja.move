module 0x9487fba7307506fa71139b1e7048068b852f2b814f7fe2c83dd0aa02f3eec1cb::sonja {
    struct SONJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONJA>(arg0, 9, b"SONJA", b"Sonja con", b"Sonjacon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0d1bf14-a283-4dc6-988d-3c377d2bbf74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

