module 0xb6e4a40f50943ee8f186850cbc3595a77e74ba3773704e50e5bee9ad3902d782::tegd {
    struct TEGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEGD>(arg0, 9, b"TEGD", b"hp12542", b"bxssdgsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79f3f824-73a1-4cb8-ae92-d5ce757245da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

