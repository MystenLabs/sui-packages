module 0x569f70587b3dd2025ea037b4d44dc5ffe828fa0304a0fa36c745bdbebeae0da4::jaan {
    struct JAAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAAN>(arg0, 9, b"JAAN", b"Mubeen", b"MubeenJaan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/855b9bff-08b9-419b-a3ab-e5839c2a17de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

