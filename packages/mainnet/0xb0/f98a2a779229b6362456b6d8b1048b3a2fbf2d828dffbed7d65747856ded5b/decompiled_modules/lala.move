module 0xb0f98a2a779229b6362456b6d8b1048b3a2fbf2d828dffbed7d65747856ded5b::lala {
    struct LALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALA>(arg0, 9, b"LALA", b"Labubu", b"Inspired by labubu, always bring you joy and luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1669180f-8965-4412-ac44-6a77d27b5488.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

