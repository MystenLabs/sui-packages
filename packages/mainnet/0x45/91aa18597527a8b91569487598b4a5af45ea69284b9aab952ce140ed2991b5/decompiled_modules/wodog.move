module 0x4591aa18597527a8b91569487598b4a5af45ea69284b9aab952ce140ed2991b5::wodog {
    struct WODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WODOG>(arg0, 9, b"WODOG", b"Galimeme", b"Ez money powered by trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ffa0261-faab-4722-ad50-96443e7b88ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

