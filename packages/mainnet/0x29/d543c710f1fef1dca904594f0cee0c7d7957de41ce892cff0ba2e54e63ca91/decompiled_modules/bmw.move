module 0x29d543c710f1fef1dca904594f0cee0c7d7957de41ce892cff0ba2e54e63ca91::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMW>(arg0, 9, b"BMW", b"BMW Fans", b"Fans auto BMW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03d1c025-6a20-4784-ab57-360ecfad67db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

