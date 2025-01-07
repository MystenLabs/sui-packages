module 0xd9da7f7d5352833c4ddc780952f5573746949a25a1080fa78f771ed46d4c2b01::tobi {
    struct TOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBI>(arg0, 9, b"TOBI", b"Gun", b"Sui top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f51076b3-a1aa-4ab2-a55e-2ffaf19e793c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

