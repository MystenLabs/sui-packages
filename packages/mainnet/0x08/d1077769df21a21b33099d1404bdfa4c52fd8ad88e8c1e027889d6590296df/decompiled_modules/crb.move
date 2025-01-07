module 0x8d1077769df21a21b33099d1404bdfa4c52fd8ad88e8c1e027889d6590296df::crb {
    struct CRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRB>(arg0, 9, b"CRB", b"CRABS", b"I need more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0b0780e-bb6b-4009-a326-91572a1c0d85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

