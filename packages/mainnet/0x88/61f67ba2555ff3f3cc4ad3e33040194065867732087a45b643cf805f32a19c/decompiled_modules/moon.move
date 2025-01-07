module 0x8861f67ba2555ff3f3cc4ad3e33040194065867732087a45b643cf805f32a19c::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"MOON", b"Cats", b"From community to community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79833797-5e7c-43d7-9bc7-0b64e29c3c49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

