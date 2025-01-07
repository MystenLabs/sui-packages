module 0xb2a49622e3ace40d3947a22d0f918a15b4429fd5fd8d0fbc98c9014df429026a::channel {
    struct CHANNEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANNEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANNEL>(arg0, 9, b"CHANNEL", b"RUSKOL", b"hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94c33d48-4019-4b5c-970f-3ac0edfd91a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANNEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHANNEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

