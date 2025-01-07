module 0x8656ec4272c74714c01ea440aaba18866316239f8ea128e2e18fca4abe5e6296::gelas {
    struct GELAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GELAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GELAS>(arg0, 9, b"GELAS", b"GelasSUI", b"Gelas on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d19c155-3590-46df-8573-eeb1cd80c49f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GELAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GELAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

