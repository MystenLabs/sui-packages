module 0xb46ecfea8b61f5e6385a3357b18485f6e923421bd0c7ae822f0bf002a8f78f45::skydog {
    struct SKYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYDOG>(arg0, 9, b"SKYDOG", b"sky coin", b"sky is name for my dog, she's cute fr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d03ab0aa-7028-4e1d-899d-f4fb58776def.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

