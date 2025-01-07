module 0xb3b5283981f211e5926100bdbe3ef683883d4b41c367715cc3d475952867874c::sx {
    struct SX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SX>(arg0, 9, b"SX", b"Star X", b"Star X sight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74e52ba6-d7c4-45b7-b32d-163409a29d10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SX>>(v1);
    }

    // decompiled from Move bytecode v6
}

