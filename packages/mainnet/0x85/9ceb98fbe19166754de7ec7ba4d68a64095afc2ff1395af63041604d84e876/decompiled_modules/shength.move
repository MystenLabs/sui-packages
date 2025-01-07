module 0x859ceb98fbe19166754de7ec7ba4d68a64095afc2ff1395af63041604d84e876::shength {
    struct SHENGTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHENGTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHENGTH>(arg0, 9, b"SHENGTH", b"Shength", b"Shength mint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92935eec-0ee6-47ef-8360-d4ebc1627c69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHENGTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHENGTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

